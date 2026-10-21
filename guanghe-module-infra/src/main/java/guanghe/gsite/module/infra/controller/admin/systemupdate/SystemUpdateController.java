package guanghe.gsite.module.infra.controller.admin.systemupdate;

import guanghe.gsite.framework.common.pojo.CommonResult;
import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateStatusRespVO;
import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateUploadReqVO;
import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateUploadRespVO;
import guanghe.gsite.module.infra.service.systemupdate.SystemUpdateService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.annotation.Resource;
import jakarta.validation.Valid;

import static guanghe.gsite.framework.common.pojo.CommonResult.success;

@Tag(name = "管理后台 - 系统更新")
@RestController
@RequestMapping("/infra/system-update")
@Validated
public class SystemUpdateController {

    @Resource
    private SystemUpdateService systemUpdateService;

    @PostMapping("/upload")
    @Operation(summary = "上传更新包")
    @PreAuthorize("@ss.hasPermission('infra:system-update:upload')")
    public CommonResult<SystemUpdateUploadRespVO> uploadUpdatePackage(@Valid SystemUpdateUploadReqVO reqVO) {
        return success(systemUpdateService.validateAndStage(reqVO.getFile(), reqVO.getType()));
    }

    @PostMapping("/apply")
    @Operation(summary = "应用系统更新")
    @PreAuthorize("@ss.hasPermission('infra:system-update:apply')")
    public CommonResult<Boolean> applyUpdate(
            @RequestParam(required = false) String backendTempPath,
            @RequestParam(required = false) String frontendTempPath) {
        systemUpdateService.applyUpdate(backendTempPath, frontendTempPath);
        return success(true);
    }

    @PostMapping("/rollback")
    @Operation(summary = "回滚到指定备份版本")
    @PreAuthorize("@ss.hasPermission('infra:system-update:rollback')")
    public CommonResult<Boolean> rollback(
            @Parameter(description = "备份时间戳", required = true) @RequestParam String backupTimestamp) {
        systemUpdateService.rollback(backupTimestamp);
        return success(true);
    }

    @GetMapping("/status")
    @Operation(summary = "获取更新状态")
    @PreAuthorize("@ss.hasPermission('infra:system-update:query')")
    public CommonResult<SystemUpdateStatusRespVO> getStatus() {
        return success(systemUpdateService.getStatus());
    }

}
