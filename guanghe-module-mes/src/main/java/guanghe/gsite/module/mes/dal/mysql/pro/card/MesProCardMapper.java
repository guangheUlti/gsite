package guanghe.gsite.module.mes.dal.mysql.pro.card;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.pro.card.vo.MesProCardPageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.pro.card.MesProCardDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 生产流转卡 Mapper
 *
 * @author 光何
 */
@Mapper
public interface MesProCardMapper extends BaseMapperX<MesProCardDO> {

    default PageResult<MesProCardDO> selectPage(MesProCardPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesProCardDO>()
                .likeIfPresent(MesProCardDO::getCode, reqVO.getCode())
                .eqIfPresent(MesProCardDO::getWorkOrderId, reqVO.getWorkOrderId())
                .eqIfPresent(MesProCardDO::getItemId, reqVO.getItemId())
                .likeIfPresent(MesProCardDO::getBatchCode, reqVO.getBatchCode())
                .orderByDesc(MesProCardDO::getId));
    }

    default MesProCardDO selectByCode(String code) {
        return selectOne(MesProCardDO::getCode, code);
    }

}
