package guanghe.gsite.module.mes.dal.mysql.wm.productissue;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.wm.productissue.vo.line.MesWmProductIssueLinePageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.wm.productissue.MesWmProductIssueLineDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * MES 领料出库单行 Mapper
 */
@Mapper
public interface MesWmProductIssueLineMapper extends BaseMapperX<MesWmProductIssueLineDO> {

    default PageResult<MesWmProductIssueLineDO> selectPage(MesWmProductIssueLinePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesWmProductIssueLineDO>()
                .eqIfPresent(MesWmProductIssueLineDO::getIssueId, reqVO.getIssueId())
                .orderByDesc(MesWmProductIssueLineDO::getId));
    }

    default List<MesWmProductIssueLineDO> selectListByIssueId(Long issueId) {
        return selectList(MesWmProductIssueLineDO::getIssueId, issueId);
    }

    default void deleteByIssueId(Long issueId) {
        delete(MesWmProductIssueLineDO::getIssueId, issueId);
    }

}
