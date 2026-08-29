package guanghe.gsite.module.mes.dal.mysql.wm.salesnotice;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.wm.salesnotice.vo.MesWmSalesNoticePageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.wm.salesnotice.MesWmSalesNoticeDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 发货通知单 Mapper
 */
@Mapper
public interface MesWmSalesNoticeMapper extends BaseMapperX<MesWmSalesNoticeDO> {

    default PageResult<MesWmSalesNoticeDO> selectPage(MesWmSalesNoticePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesWmSalesNoticeDO>()
                .likeIfPresent(MesWmSalesNoticeDO::getCode, reqVO.getCode())
                .likeIfPresent(MesWmSalesNoticeDO::getName, reqVO.getName())
                .likeIfPresent(MesWmSalesNoticeDO::getSalesOrderCode, reqVO.getSalesOrderCode())
                .eqIfPresent(MesWmSalesNoticeDO::getClientId, reqVO.getClientId())
                .eqIfPresent(MesWmSalesNoticeDO::getStatus, reqVO.getStatus())
                .orderByDesc(MesWmSalesNoticeDO::getId));
    }

    default MesWmSalesNoticeDO selectByCode(String code) {
        return selectOne(MesWmSalesNoticeDO::getCode, code);
    }

}
