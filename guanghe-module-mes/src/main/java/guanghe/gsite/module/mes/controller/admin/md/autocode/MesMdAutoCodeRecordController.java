package guanghe.gsite.module.mes.controller.admin.md.autocode;

import guanghe.gsite.framework.common.pojo.CommonResult;
import guanghe.gsite.module.mes.controller.admin.md.autocode.vo.record.MesMdAutoCodeGenerateReqVO;
import guanghe.gsite.module.mes.service.md.autocode.MesMdAutoCodeRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;

import static guanghe.gsite.framework.common.pojo.CommonResult.success;

@Tag(name = "管理后台 - MES 编码生成记录")
@RestController
@RequestMapping("/mes/md/auto-code-record")
@Validated
public class MesMdAutoCodeRecordController {

    @Resource
    private MesMdAutoCodeRecordService autoCodeRecordService;

    @PostMapping("/generate")
    @Operation(summary = "生成编码")
    @PreAuthorize("@ss.hasPermission('mes:auto-code-rule:query')")
    public CommonResult<String> generateAutoCode(@Valid @RequestBody MesMdAutoCodeGenerateReqVO generateReqVO) {
        String code = autoCodeRecordService.generateAutoCode(generateReqVO.getRuleCode(), generateReqVO.getInputChar());
        return success(code);
    }

}
