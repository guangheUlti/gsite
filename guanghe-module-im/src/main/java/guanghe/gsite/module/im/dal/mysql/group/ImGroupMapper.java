package guanghe.gsite.module.im.dal.mysql.group;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.im.controller.admin.manager.group.vo.ImGroupManagerPageReqVO;
import guanghe.gsite.module.im.dal.dataobject.group.ImGroupDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * IM 群 Mapper
 *
 * @author 光何
 */
@Mapper
public interface ImGroupMapper extends BaseMapperX<ImGroupDO> {

    default ImGroupDO selectByIdForUpdate(Long id) {
        return selectOne(new LambdaQueryWrapperX<ImGroupDO>()
                .eq(ImGroupDO::getId, id)
                .last("FOR UPDATE"));
    }

    default PageResult<ImGroupDO> selectPage(ImGroupManagerPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<ImGroupDO>()
                .likeIfPresent(ImGroupDO::getName, reqVO.getName())
                .eqIfPresent(ImGroupDO::getOwnerUserId, reqVO.getOwnerUserId())
                .eqIfPresent(ImGroupDO::getStatus, reqVO.getStatus())
                .eqIfPresent(ImGroupDO::getBanned, reqVO.getBanned())
                .betweenIfPresent(ImGroupDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(ImGroupDO::getId));
    }

}
