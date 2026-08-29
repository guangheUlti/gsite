package guanghe.gsite.module.mes.dal.mysql.pro.andon;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.pro.andon.vo.config.MesProAndonConfigPageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.pro.andon.MesProAndonConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * MES 安灯呼叫配置 Mapper
 *
 * @author 光何
 */
@Mapper
public interface MesProAndonConfigMapper extends BaseMapperX<MesProAndonConfigDO> {

    default PageResult<MesProAndonConfigDO> selectPage(MesProAndonConfigPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesProAndonConfigDO>()
                .likeIfPresent(MesProAndonConfigDO::getReason, reqVO.getReason())
                .eqIfPresent(MesProAndonConfigDO::getLevel, reqVO.getLevel())
                .orderByDesc(MesProAndonConfigDO::getId));
    }

}
