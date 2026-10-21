package guanghe.gsite.module.infra.controller.admin.systemupdate.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Schema(description = "管理后台 - 系统更新上传 Request VO")
@Data
public class SystemUpdateUploadReqVO {

    @Schema(description = "更新文件", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotNull(message = "更新文件不能为空")
    private MultipartFile file;

    @Schema(description = "更新类型：backend / frontend", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotBlank(message = "更新类型不能为空")
    private String type;

}
