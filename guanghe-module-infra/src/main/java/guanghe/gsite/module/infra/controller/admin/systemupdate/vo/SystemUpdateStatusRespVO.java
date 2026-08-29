package guanghe.gsite.module.infra.controller.admin.systemupdate.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Schema(description = "管理后台 - 系统更新状态 Response VO")
@Data
public class SystemUpdateStatusRespVO {

    @Schema(description = "是否正在更新中")
    private Boolean updating;

    @Schema(description = "当前进度描述")
    private String progressMessage;

    @Schema(description = "上次更新时间")
    private LocalDateTime lastUpdateTime;

    @Schema(description = "上次更新结果：success / failed / rollback-success")
    private String lastUpdateResult;

    @Schema(description = "当前后端 jar 文件名")
    private String currentBackendJar;

    @Schema(description = "可用备份列表")
    private List<BackupInfo> backups;

    @Data
    @Schema(description = "备份信息")
    public static class BackupInfo {

        @Schema(description = "备份时间戳（yyyyMMddHHmmss）")
        private String timestamp;

        @Schema(description = "备份类型：backend / frontend / both")
        private String type;

        @Schema(description = "描述")
        private String description;
    }

}
