package guanghe.gsite.module.mes.dal.mysql.qc.indicatorresult;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.qc.indicatorresult.vo.MesQcIndicatorResultPageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.qc.indicatorresult.MesQcIndicatorResultDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 检验结果记录 Mapper
 *
 * @author 光何
 */
@Mapper
public interface MesQcIndicatorResultMapper extends BaseMapperX<MesQcIndicatorResultDO> {

    default PageResult<MesQcIndicatorResultDO> selectPage(MesQcIndicatorResultPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesQcIndicatorResultDO>()
                .eqIfPresent(MesQcIndicatorResultDO::getQcId, reqVO.getQcId())
                .eqIfPresent(MesQcIndicatorResultDO::getQcType, reqVO.getQcType())
                .likeIfPresent(MesQcIndicatorResultDO::getCode, reqVO.getCode())
                .eqIfPresent(MesQcIndicatorResultDO::getItemId, reqVO.getItemId())
                .orderByDesc(MesQcIndicatorResultDO::getId));
    }

    default Long selectCountByQcIdAndType(Long qcId, Integer qcType) {
        return selectCount(new LambdaQueryWrapperX<MesQcIndicatorResultDO>()
                .eq(MesQcIndicatorResultDO::getQcId, qcId)
                .eq(MesQcIndicatorResultDO::getQcType, qcType));
    }

}
