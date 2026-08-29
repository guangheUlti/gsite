package guanghe.gsite.module.mes.dal.mysql.md.client;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.mes.controller.admin.md.client.vo.MesMdClientPageReqVO;
import guanghe.gsite.module.mes.dal.dataobject.md.client.MesMdClientDO;
import org.apache.ibatis.annotations.Mapper;




/**
 * MES 客户 Mapper
 *
 * @author 光何
 */
@Mapper
public interface MesMdClientMapper extends BaseMapperX<MesMdClientDO> {

    default PageResult<MesMdClientDO> selectPage(MesMdClientPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MesMdClientDO>()
                .eqIfPresent(MesMdClientDO::getCode, reqVO.getCode())
                .likeIfPresent(MesMdClientDO::getName, reqVO.getName())
                .likeIfPresent(MesMdClientDO::getNickname, reqVO.getNickname())
                .likeIfPresent(MesMdClientDO::getEnglishName, reqVO.getEnglishName())
                .eqIfPresent(MesMdClientDO::getType, reqVO.getType())
                .eqIfPresent(MesMdClientDO::getStatus, reqVO.getStatus())
                .orderByDesc(MesMdClientDO::getId));
    }

    default MesMdClientDO selectByCode(String code) {
        return selectOne(MesMdClientDO::getCode, code);
    }

    default MesMdClientDO selectByName(String name) {
        return selectOne(MesMdClientDO::getName, name);
    }

    default MesMdClientDO selectByNickname(String nickname) {
        return selectOne(MesMdClientDO::getNickname, nickname);
    }

}
