package guanghe.gsite.module.infra.framework.systemupdate;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "guanghe.system-update")
@Data
public class SystemUpdateProperties {

    /** 当前运行的后端 jar 绝对路径 */
    private String backendJarPath;

    /** nginx html 静态文件目录绝对路径 */
    private String frontendDir;

    /** 备份根目录（staging/jar/frontend 子目录自动创建） */
    private String backupDir;

    /** 上传文件大小上限（MB），默认 500 */
    private int maxUploadSizeMb = 500;

    /** java 可执行文件路径 */
    private String javaCommand = "java";

    /** 重启时附加的 JVM 参数 */
    private String jvmArgs = "";

    /** 重启时传递给 Spring Boot 的参数（如 --spring.profiles.active=deploy） */
    private String springArgs = "";

}
