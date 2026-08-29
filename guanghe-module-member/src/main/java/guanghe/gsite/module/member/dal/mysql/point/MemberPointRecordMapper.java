package guanghe.gsite.module.member.dal.mysql.point;

import guanghe.gsite.framework.common.pojo.PageParam;
import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.member.controller.admin.point.vo.recrod.MemberPointRecordPageReqVO;
import guanghe.gsite.module.member.controller.app.point.vo.AppMemberPointRecordPageReqVO;
import guanghe.gsite.module.member.dal.dataobject.point.MemberPointRecordDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Set;

/**
 * 用户积分记录 Mapper
 *
 * @author 光何
 */
@Mapper
public interface MemberPointRecordMapper extends BaseMapperX<MemberPointRecordDO> {

    default PageResult<MemberPointRecordDO> selectPage(MemberPointRecordPageReqVO reqVO, Set<Long> userIds) {
        return selectPage(reqVO, new LambdaQueryWrapperX<MemberPointRecordDO>()
                .inIfPresent(MemberPointRecordDO::getUserId, userIds)
                .eqIfPresent(MemberPointRecordDO::getUserId, reqVO.getUserId())
                .eqIfPresent(MemberPointRecordDO::getBizType, reqVO.getBizType())
                .likeIfPresent(MemberPointRecordDO::getTitle, reqVO.getTitle())
                .orderByDesc(MemberPointRecordDO::getId));
    }

    default PageResult<MemberPointRecordDO> selectPage(Long userId, AppMemberPointRecordPageReqVO pageReqVO) {
        return selectPage(pageReqVO, new LambdaQueryWrapperX<MemberPointRecordDO>()
                .eq(MemberPointRecordDO::getUserId, userId)
                .betweenIfPresent(MemberPointRecordDO::getCreateTime, pageReqVO.getCreateTime())
                .gt(Boolean.TRUE.equals(pageReqVO.getAddStatus()),
                        MemberPointRecordDO::getPoint, 0)
                .lt(Boolean.FALSE.equals(pageReqVO.getAddStatus()),
                        MemberPointRecordDO::getPoint, 0)
                .orderByDesc(MemberPointRecordDO::getId));
    }

}
