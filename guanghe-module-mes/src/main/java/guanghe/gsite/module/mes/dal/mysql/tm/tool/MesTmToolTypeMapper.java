package guanghe.gsite.module.mes.dal.mysql.tm.tool;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.tm.tool.vo.type.MesTmToolTypePageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.tm.tool.MesTmToolTypeDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * MES 工具类型 Mapper
 *
 * @author 光何
 */
@Mapper
public interface MesTmToolTypeMapper extends BaseMapperX<MesTmToolTypeDO> {

    default PageResult<MesTmToolTypeDO> selectPage(MesTmToolTypePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesTmToolTypeDO>()
                .likeIfPresent(MesTmToolTypeDO::getCode, reqVO.getCode())
                .likeIfPresent(MesTmToolTypeDO::getName, reqVO.getName())
                .eqIfPresent(MesTmToolTypeDO::getMaintenType, reqVO.getMaintenType())
                .orderByDesc(MesTmToolTypeDO::getId));
    }

    default MesTmToolTypeDO selectByCode(String code) {
        return selectOne(MesTmToolTypeDO::getCode, code);
    }

    default MesTmToolTypeDO selectByName(String name) {
        return selectOne(MesTmToolTypeDO::getName, name);
    }

    default List<MesTmToolTypeDO> selectList() {
        return selectList(new LambdaQueryWrapperX<MesTmToolTypeDO>()
                .orderByDesc(MesTmToolTypeDO::getId));
    }

}
