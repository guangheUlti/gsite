package guanghe.gsite.module.ai.controller.admin.knowledge.vo.segment;

import guanghe.gsite.framework.common.enums.CommonStatusEnum;
import guanghe.gsite.framework.common.pojo.PageParam;
import guanghe.gsite.framework.common.validation.InEnum;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Schema(description = "管理后台 - AI 知识库分段的分页 Request VO")
@Data
public class AiKnowledgeSegmentPageReqVO extends PageParam {

    @Schema(description = "文档编号", example = "1")
    private Long documentId;

    @Schema(description = "分段内容关键字", example = "Java 开发")
    private String content;

    @Schema(description = "分段状态", example = "1")
    @InEnum(CommonStatusEnum.class)
    private Integer status;

}
