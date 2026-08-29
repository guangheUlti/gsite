package guanghe.gsite.module.im.dal.mysql.face;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.im.controller.admin.manager.face.vo.useritem.ImFaceUserItemManagerPageReqVO;
import guanghe.gsite.module.im.dal.dataobject.face.ImFaceUserItemDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * IM 用户私有表情 Mapper
 *
 * @author 光何
 */
@Mapper
public interface ImFaceUserItemMapper extends BaseMapperX<ImFaceUserItemDO> {

    default List<ImFaceUserItemDO> selectListByUserId(Long userId) {
        return selectList(new LambdaQueryWrapperX<ImFaceUserItemDO>()
                .eq(ImFaceUserItemDO::getUserId, userId)
                .orderByAsc(ImFaceUserItemDO::getSort)
                .orderByDesc(ImFaceUserItemDO::getId));
    }

    default ImFaceUserItemDO selectByUserIdAndUrl(Long userId, String url) {
        return selectOne(new LambdaQueryWrapperX<ImFaceUserItemDO>()
                .eq(ImFaceUserItemDO::getUserId, userId)
                .eq(ImFaceUserItemDO::getUrl, url));
    }

    default Long selectCountByUserId(Long userId) {
        return selectCount(ImFaceUserItemDO::getUserId, userId);
    }

    default PageResult<ImFaceUserItemDO> selectPage(ImFaceUserItemManagerPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<ImFaceUserItemDO>()
                .eqIfPresent(ImFaceUserItemDO::getUserId, reqVO.getUserId())
                .likeIfPresent(ImFaceUserItemDO::getName, reqVO.getName())
                .betweenIfPresent(ImFaceUserItemDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(ImFaceUserItemDO::getId));
    }

}
