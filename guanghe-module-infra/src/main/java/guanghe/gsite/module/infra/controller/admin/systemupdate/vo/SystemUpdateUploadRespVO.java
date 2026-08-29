package guanghe.gsite.module.infra.controller.admin.systemupdate.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "管理后台 - 系统更新上传 Response VO")
@Data
public class SystemUpdateUploadRespVO {

    @Schema(description = "暂存文件路径")
    private String tempFilePath;

    @Schema(description = "原始文件名")
    private String fileName;

    @Schema(description = "文件大小（字节）")
    private Long fileSize;

    @Schema(description = "更新类型：backend / frontend")
    private String type;

    @Schema(description = "校验附加信息（如 zip 是否含顶层 html/ 目录）")
    private String validationInfo;

}
