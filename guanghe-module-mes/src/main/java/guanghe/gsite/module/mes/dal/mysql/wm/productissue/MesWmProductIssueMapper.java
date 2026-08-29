package guanghe.gsite.module.mes.dal.mysql.wm.productissue;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.wm.productissue.vo.MesWmProductIssuePageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.wm.productissue.MesWmProductIssueDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 领料出库单 Mapper
 */
@Mapper
public interface MesWmProductIssueMapper extends BaseMapperX<MesWmProductIssueDO> {

    default PageResult<MesWmProductIssueDO> selectPage(MesWmProductIssuePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesWmProductIssueDO>()
                .likeIfPresent(MesWmProductIssueDO::getCode, reqVO.getCode())
                .likeIfPresent(MesWmProductIssueDO::getName, reqVO.getName())
                .eqIfPresent(MesWmProductIssueDO::getWorkstationId, reqVO.getWorkstationId())
                .eqIfPresent(MesWmProductIssueDO::getWorkOrderId, reqVO.getWorkOrderId())
                .eqIfPresent(MesWmProductIssueDO::getStatus, reqVO.getStatus())
                .betweenIfPresent(MesWmProductIssueDO::getIssueDate, reqVO.getIssueDate())
                .orderByDesc(MesWmProductIssueDO::getId));
    }

    default MesWmProductIssueDO selectByCode(String code) {
        return selectOne(MesWmProductIssueDO::getCode, code);
    }

}
