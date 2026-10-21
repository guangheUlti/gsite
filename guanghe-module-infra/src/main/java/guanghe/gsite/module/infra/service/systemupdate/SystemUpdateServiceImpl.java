package guanghe.gsite.module.infra.service.systemupdate;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.StrUtil;
import guanghe.gsite.framework.common.exception.ServiceException;
import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateStatusRespVO;
import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateUploadRespVO;
import guanghe.gsite.module.infra.framework.systemupdate.SystemUpdateProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.annotation.Resource;
import java.io.*;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.locks.ReentrantLock;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import java.lang.management.ManagementFactory;

import static guanghe.gsite.framework.common.exception.util.ServiceExceptionUtil.exception;
import static guanghe.gsite.module.infra.enums.ErrorCodeConstants.*;

@Slf4j
@Service
@EnableConfigurationProperties(SystemUpdateProperties.class)
public class SystemUpdateServiceImpl implements SystemUpdateService {

    private static final Pattern JAR_NAME_PATTERN = Pattern.compile("^guanghe-server.*\\.jar$", Pattern.CASE_INSENSITIVE);
    private static final DateTimeFormatter TS_FMT = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    @Resource
    private SystemUpdateProperties props;

    private final ReentrantLock lock = new ReentrantLock();

    // volatile 状态字段，供 getStatus 无锁读取
    private volatile boolean updating = false;
    private volatile String progressMessage = "";
    private volatile LocalDateTime lastUpdateTime;
    private volatile String lastUpdateResult;

    // ==================== upload ====================

    @Override
    public SystemUpdateUploadRespVO validateAndStage(MultipartFile file, String type) {
        String originalName = file.getOriginalFilename();
        if (originalName == null) {
            originalName = "unknown";
        }
        String ext = FileUtil.extName(originalName).toLowerCase();

        // 1. 扩展名校验
        if ("backend".equals(type)) {
            if (!"jar".equals(ext)) {
                throw exception(SYSTEM_UPDATE_FILE_INVALID_EXTENSION);
            }
            if (!JAR_NAME_PATTERN.matcher(originalName).matches()) {
                throw exception(SYSTEM_UPDATE_JAR_NAME_INVALID);
            }
        } else if ("frontend".equals(type)) {
            if (!"zip".equals(ext)) {
                throw exception(SYSTEM_UPDATE_FILE_INVALID_EXTENSION);
            }
        } else {
            throw exception(SYSTEM_UPDATE_FILE_INVALID_EXTENSION);
        }

        // 2. zip 内容校验（前端包必须含 index.html，同时检测顶层 html/ 目录）
        String validationInfo = "";
        if ("frontend".equals(type)) {
            validationInfo = validateZip(file);
        }

        // 3. 暂存到 staging 目录
        ensureDir(getStagingDir());
        String stagedName = UUID.randomUUID().toString().substring(0, 8) + "-" + originalName;
        Path stagedPath = getStagingDir().resolve(stagedName);
        try {
            file.transferTo(stagedPath.toFile());
        } catch (IOException e) {
            throw exception(SYSTEM_UPDATE_APPLY_FAILED, e.getMessage());
        }

        SystemUpdateUploadRespVO resp = new SystemUpdateUploadRespVO();
        resp.setTempFilePath(stagedPath.toString());
        resp.setFileName(originalName);
        resp.setFileSize(file.getSize());
        resp.setType(type);
        resp.setValidationInfo(validationInfo);
        return resp;
    }

    /**
     * 校验 zip：必须有 index.html；检测是否有顶层 html/ 目录；防 zip slip。
     * 返回描述信息字符串。
     */
    private String validateZip(MultipartFile file) {
        boolean hasIndexHtml = false;
        boolean hasTopLevelHtmlDir = false;
        try (ZipInputStream zis = new ZipInputStream(file.getInputStream())) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                String name = entry.getName();
                // zip slip 防护
                if (name.contains("..")) {
                    throw exception(SYSTEM_UPDATE_ZIP_SLIP);
                }
                // 检测 index.html（任意层级）
                String normalized = name.replace('\\', '/');
                if (normalized.endsWith("index.html") && !entry.isDirectory()) {
                    hasIndexHtml = true;
                }
                // 检测顶层 html/ 目录
                if (normalized.startsWith("html/") || normalized.equals("html")) {
                    hasTopLevelHtmlDir = true;
                }
            }
        } catch (IOException e) {
            throw exception(SYSTEM_UPDATE_APPLY_FAILED, "无法读取 zip 文件：" + e.getMessage());
        }
        if (!hasIndexHtml) {
            throw exception(SYSTEM_UPDATE_ZIP_NO_INDEX);
        }
        return hasTopLevelHtmlDir ? "检测到顶层 html/ 目录，解压时将自动剥离" : "zip 结构正常，直接解压";
    }

    // ==================== apply ====================

    @Override
    public void applyUpdate(String backendTempPath, String frontendTempPath) {
        if (!lock.tryLock()) {
            throw exception(SYSTEM_UPDATE_IN_PROGRESS);
        }
        try {
            updating = true;
            String ts = LocalDateTime.now().format(TS_FMT);

            // 前端先更新（后端更新会触发重启）
            if (StrUtil.isNotBlank(frontendTempPath)) {
                applyFrontend(frontendTempPath, ts);
            }
            if (StrUtil.isNotBlank(backendTempPath)) {
                applyBackend(backendTempPath, ts);
            }

            lastUpdateTime = LocalDateTime.now();
            lastUpdateResult = "success";
            progressMessage = "更新完成";
        } catch (ServiceException e) {
            lastUpdateResult = "failed";
            progressMessage = "更新失败：" + e.getMessage();
            throw e;
        } catch (Exception e) {
            lastUpdateResult = "failed";
            progressMessage = "更新失败：" + e.getMessage();
            throw exception(SYSTEM_UPDATE_APPLY_FAILED, e.getMessage());
        } finally {
            // 如果触发了后端重启，这里不会执行到（System.exit）
            // 仅前端更新或失败时释放锁
            if (!"success".equals(lastUpdateResult) || StrUtil.isBlank(backendTempPath)) {
                updating = false;
                lock.unlock();
            }
        }
    }

    private void applyFrontend(String zipPath, String ts) throws IOException {
        checkConfig(props.getFrontendDir(), "frontend-dir");
        progressMessage = "正在备份前端文件...";
        Path frontendDir = Paths.get(props.getFrontendDir());
        Path backupFrontendDir = getBackupDir().resolve("frontend").resolve(ts);
        ensureDir(backupFrontendDir);
        if (Files.exists(frontendDir) && Files.isDirectory(frontendDir)) {
            copyDirectory(frontendDir, backupFrontendDir);
        }

        progressMessage = "正在解压前端文件...";
        // 清空目标目录
        if (Files.exists(frontendDir)) {
            try (Stream<Path> walk = Files.walk(frontendDir, 1)) {
                walk.skip(1).sorted(Comparator.reverseOrder()).forEach(p -> {
                    try { Files.deleteIfExists(p); } catch (IOException ignored) {}
                });
            }
        }
        ensureDir(frontendDir);

        // 解压，检测是否需要剥离顶层 html/
        unzipWithOptionalStrip(zipPath, frontendDir);

        // 验证 index.html 存在
        if (!Files.exists(frontendDir.resolve("index.html"))) {
            throw exception(SYSTEM_UPDATE_APPLY_FAILED, "解压后未找到 index.html");
        }
        progressMessage = "前端更新完成";
    }

    private void applyBackend(String jarPath, String ts) throws IOException {
        checkConfig(props.getBackendJarPath(), "backend-jar-path");
        progressMessage = "正在备份当前后端 jar...";
        Path currentJar = Paths.get(props.getBackendJarPath());
        Path backupJarDir = getBackupDir().resolve("jar");
        ensureDir(backupJarDir);
        String backupName = "guanghe-server-" + ts + ".jar";
        Files.copy(currentJar, backupJarDir.resolve(backupName), StandardCopyOption.REPLACE_EXISTING);

        progressMessage = "正在生成重启脚本...";
        Path restartScript = getBackupDir().resolve("restart-" + ts + ".ps1");
        long pid = getCurrentPid();
        String script = buildRestartScript(pid, jarPath, currentJar.toString());
        Files.write(restartScript, script.getBytes("UTF-8"));

        progressMessage = "即将停止服务并重启...";
        // 异步延迟执行重启，确保 HTTP 响应已发送
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(2000);
                ProcessBuilder pb = new ProcessBuilder(
                        "powershell", "-ExecutionPolicy", "Bypass", "-File", restartScript.toString()
                );
                pb.inheritIO();
                pb.start();
                log.info("[系统更新] 重启脚本已启动，当前 JVM 即将退出");
                System.exit(0);
            } catch (Exception e) {
                log.error("[系统更新] 重启失败", e);
            }
        });
    }

    private String buildRestartScript(long pid, String newJarPath, String targetJarPath) {
        String javaCmd = StrUtil.blankToDefault(props.getJavaCommand(), "java");
        String jvmArgs = StrUtil.blankToDefault(props.getJvmArgs(), "");
        String springArgs = StrUtil.blankToDefault(props.getSpringArgs(), "");
        String workDir = Paths.get(targetJarPath).getParent().toString();

        return "# Auto-generated restart script\n" +
                "$ErrorActionPreference = 'Stop'\n" +
                "$pid = " + pid + "\n" +
                "$newJar = '" + newJarPath.replace("'", "''") + "'\n" +
                "$targetJar = '" + targetJarPath.replace("'", "''") + "'\n" +
                "$javaCmd = '" + javaCmd.replace("'", "''") + "'\n" +
                "$jvmArgs = '" + jvmArgs.replace("'", "''") + "'\n" +
                "$springArgs = '" + springArgs.replace("'", "''") + "'\n" +
                "$workDir = '" + workDir.replace("'", "''") + "'\n" +
                "\n" +
                "# Wait for current JVM to exit\n" +
                "while (Get-Process -Id $pid -ErrorAction SilentlyContinue) {\n" +
                "    Start-Sleep -Seconds 1\n" +
                "}\n" +
                "\n" +
                "# Replace jar\n" +
                "Copy-Item -Path $newJar -Destination $targetJar -Force\n" +
                "\n" +
                "# Start new JVM\n" +
                "$allArgs = \"$jvmArgs -jar $targetJar $springArgs\".Trim()\n" +
                "Start-Process -FilePath $javaCmd -ArgumentList $allArgs -WorkingDirectory $workDir -WindowStyle Hidden\n";
    }

    // ==================== rollback ====================

    @Override
    public void rollback(String backupTimestamp) {
        if (!lock.tryLock()) {
            throw exception(SYSTEM_UPDATE_IN_PROGRESS);
        }
        try {
            updating = true;
            progressMessage = "正在回滚...";

            Path jarBackup = getBackupDir().resolve("jar").resolve("guanghe-server-" + backupTimestamp + ".jar");
            Path frontendBackup = getBackupDir().resolve("frontend").resolve(backupTimestamp);

            boolean hasJar = Files.exists(jarBackup);
            boolean hasFrontend = Files.exists(frontendBackup) && Files.isDirectory(frontendBackup);
            if (!hasJar && !hasFrontend) {
                throw exception(SYSTEM_UPDATE_BACKUP_NOT_FOUND);
            }

            // 前端先恢复
            if (hasFrontend) {
                checkConfig(props.getFrontendDir(), "frontend-dir");
                progressMessage = "正在恢复前端文件...";
                Path frontendDir = Paths.get(props.getFrontendDir());
                // 清空
                if (Files.exists(frontendDir)) {
                    try (Stream<Path> walk = Files.walk(frontendDir, 1)) {
                        walk.skip(1).sorted(Comparator.reverseOrder()).forEach(p -> {
                            try { Files.deleteIfExists(p); } catch (IOException ignored) {}
                        });
                    }
                }
                ensureDir(frontendDir);
                copyDirectory(frontendBackup, frontendDir);
            }

            // 后端恢复（触发重启）
            if (hasJar) {
                checkConfig(props.getBackendJarPath(), "backend-jar-path");
                progressMessage = "正在恢复后端 jar 并重启...";
                String ts = LocalDateTime.now().format(TS_FMT);
                Path restartScript = getBackupDir().resolve("rollback-restart-" + ts + ".ps1");
                long pid = getCurrentPid();
                String script = buildRestartScript(pid, jarBackup.toString(), props.getBackendJarPath());
                Files.write(restartScript, script.getBytes("UTF-8"));

                CompletableFuture.runAsync(() -> {
                    try {
                        Thread.sleep(2000);
                        ProcessBuilder pb = new ProcessBuilder(
                                "powershell", "-ExecutionPolicy", "Bypass", "-File", restartScript.toString()
                        );
                        pb.inheritIO();
                        pb.start();
                        log.info("[系统更新] 回滚重启脚本已启动");
                        System.exit(0);
                    } catch (Exception e) {
                        log.error("[系统更新] 回滚重启失败", e);
                    }
                });
            }

            lastUpdateTime = LocalDateTime.now();
            lastUpdateResult = "rollback-success";
            progressMessage = "回滚完成";
        } catch (ServiceException e) {
            lastUpdateResult = "rollback-failed";
            progressMessage = "回滚失败：" + e.getMessage();
            throw e;
        } catch (Exception e) {
            lastUpdateResult = "rollback-failed";
            progressMessage = "回滚失败：" + e.getMessage();
            throw exception(SYSTEM_UPDATE_ROLLBACK_FAILED, e.getMessage());
        } finally {
            if (!"rollback-success".equals(lastUpdateResult) || !Files.exists(
                    getBackupDir().resolve("jar").resolve("guanghe-server-" + backupTimestamp + ".jar"))) {
                updating = false;
                lock.unlock();
            }
        }
    }

    // ==================== status ====================

    @Override
    public SystemUpdateStatusRespVO getStatus() {
        SystemUpdateStatusRespVO vo = new SystemUpdateStatusRespVO();
        vo.setUpdating(updating);
        vo.setProgressMessage(progressMessage);
        vo.setLastUpdateTime(lastUpdateTime);
        vo.setLastUpdateResult(lastUpdateResult);

        // 当前 jar 文件名
        if (StrUtil.isNotBlank(props.getBackendJarPath())) {
            vo.setCurrentBackendJar(Paths.get(props.getBackendJarPath()).getFileName().toString());
        }

        // 扫描备份列表
        vo.setBackups(scanBackups());
        return vo;
    }

    private List<SystemUpdateStatusRespVO.BackupInfo> scanBackups() {
        List<SystemUpdateStatusRespVO.BackupInfo> list = new ArrayList<>();
        Path backupRoot = getBackupDir();
        if (!Files.exists(backupRoot)) {
            return list;
        }

        // 收集所有时间戳
        Set<String> timestamps = new TreeSet<>(Collections.reverseOrder());
        Path jarDir = backupRoot.resolve("jar");
        if (Files.exists(jarDir)) {
            try (Stream<Path> files = Files.list(jarDir)) {
                files.filter(p -> p.toString().endsWith(".jar")).forEach(p -> {
                    String name = p.getFileName().toString();
                    // guanghe-server-{ts}.jar
                    int start = name.indexOf("guanghe-server-") + "guanghe-server-".length();
                    int end = name.lastIndexOf(".jar");
                    if (start > 0 && end > start) {
                        timestamps.add(name.substring(start, end));
                    }
                });
            } catch (IOException ignored) {}
        }
        Path frontendDir = backupRoot.resolve("frontend");
        if (Files.exists(frontendDir)) {
            try (Stream<Path> dirs = Files.list(frontendDir)) {
                dirs.filter(Files::isDirectory).forEach(p -> timestamps.add(p.getFileName().toString()));
            } catch (IOException ignored) {}
        }

        for (String ts : timestamps) {
            boolean hasJar = Files.exists(jarDir.resolve("guanghe-server-" + ts + ".jar"));
            boolean hasFrontend = Files.exists(frontendDir.resolve(ts));
            SystemUpdateStatusRespVO.BackupInfo info = new SystemUpdateStatusRespVO.BackupInfo();
            info.setTimestamp(ts);
            if (hasJar && hasFrontend) {
                info.setType("both");
                info.setDescription("后端 + 前端备份");
            } else if (hasJar) {
                info.setType("backend");
                info.setDescription("后端 jar 备份");
            } else {
                info.setType("frontend");
                info.setDescription("前端文件备份");
            }
            list.add(info);
        }
        return list;
    }

    // ==================== helpers ====================

    /**
     * JDK 8 兼容方式获取当前进程 PID
     */
    private long getCurrentPid() {
        String name = ManagementFactory.getRuntimeMXBean().getName();
        return Long.parseLong(name.split("@")[0]);
    }

    private void unzipWithOptionalStrip(String zipPath, Path targetDir) throws IOException {
        // 先检测是否需要剥离顶层 html/
        boolean stripHtmlPrefix = false;
        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(zipPath))) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                String name = entry.getName().replace('\\', '/');
                if (name.startsWith("html/") || name.equals("html")) {
                    stripHtmlPrefix = true;
                    break;
                }
            }
        }

        try (ZipInputStream zis = new ZipInputStream(new FileInputStream(zipPath))) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                String name = entry.getName().replace('\\', '/');
                // zip slip 二次防护
                if (name.contains("..")) {
                    throw exception(SYSTEM_UPDATE_ZIP_SLIP);
                }
                if (stripHtmlPrefix) {
                    if (name.equals("html") || name.equals("html/")) {
                        continue; // skip the directory entry itself
                    }
                    if (name.startsWith("html/")) {
                        name = name.substring("html/".length());
                    }
                }
                if (name.isEmpty()) {
                    continue;
                }
                Path outPath = targetDir.resolve(name);
                if (entry.isDirectory()) {
                    Files.createDirectories(outPath);
                } else {
                    Files.createDirectories(outPath.getParent());
                    Files.copy(zis, outPath, StandardCopyOption.REPLACE_EXISTING);
                }
            }
        }
    }

    private void copyDirectory(Path source, Path target) throws IOException {
        try (Stream<Path> walk = Files.walk(source)) {
            walk.forEach(src -> {
                Path dest = target.resolve(source.relativize(src));
                try {
                    if (Files.isDirectory(src)) {
                        Files.createDirectories(dest);
                    } else {
                        Files.createDirectories(dest.getParent());
                        Files.copy(src, dest, StandardCopyOption.REPLACE_EXISTING);
                    }
                } catch (IOException e) {
                    throw new UncheckedIOException(e);
                }
            });
        }
    }

    private void ensureDir(Path dir) {
        try {
            Files.createDirectories(dir);
        } catch (IOException e) {
            throw exception(SYSTEM_UPDATE_APPLY_FAILED, "无法创建目录：" + dir);
        }
    }

    private void checkConfig(String value, String name) {
        if (StrUtil.isBlank(value)) {
            throw exception(SYSTEM_UPDATE_CONFIG_MISSING, name);
        }
    }

    private Path getBackupDir() {
        return Paths.get(StrUtil.blankToDefault(props.getBackupDir(), "./backup"));
    }

    private Path getStagingDir() {
        return getBackupDir().resolve("staging");
    }

}
