package guanghe.gsite.module.mes.dal.mysql.wm.returnissue;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.wm.returnissue.vo.MesWmReturnIssuePageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.wm.returnissue.MesWmReturnIssueDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 生产退料单 Mapper
 */
@Mapper
public interface MesWmReturnIssueMapper extends BaseMapperX<MesWmReturnIssueDO> {

    default PageResult<MesWmReturnIssueDO> selectPage(MesWmReturnIssuePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesWmReturnIssueDO>()
                .likeIfPresent(MesWmReturnIssueDO::getCode, reqVO.getCode())
                .likeIfPresent(MesWmReturnIssueDO::getName, reqVO.getName())
                .eqIfPresent(MesWmReturnIssueDO::getWorkstationId, reqVO.getWorkstationId())
                .eqIfPresent(MesWmReturnIssueDO::getWorkOrderId, reqVO.getWorkOrderId())
                .eqIfPresent(MesWmReturnIssueDO::getType, reqVO.getType())
                .orderByDesc(MesWmReturnIssueDO::getId));
    }

    default MesWmReturnIssueDO selectByCode(String code) {
        return selectOne(MesWmReturnIssueDO::getCode, code);
    }

}
