package guanghe.gsite.module.hrm.dal.mysql.attendance.config;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.hrm.controller.admin.attendance.vo.group.HrmAttendanceGroupPageReqVO;
import guanghe.gsite.module.hrm.dal.dataobject.attendance.config.HrmAttendanceGroupDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HrmAttendanceGroupMapper extends BaseMapperX<HrmAttendanceGroupDO> {

    default PageResult<HrmAttendanceGroupDO> selectPage(HrmAttendanceGroupPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<HrmAttendanceGroupDO>()
                .likeIfPresent(HrmAttendanceGroupDO::getName, reqVO.getName())
                .eqIfPresent(HrmAttendanceGroupDO::getDefaultStatus, reqVO.getDefaultStatus())
                .orderByDesc(HrmAttendanceGroupDO::getId));
    }

    default HrmAttendanceGroupDO selectByName(String name) {
        return selectFirstOne(HrmAttendanceGroupDO::getName, name);
    }

    default List<HrmAttendanceGroupDO> selectListOrderByDefaultStatusAndId() {
        return selectList(new LambdaQueryWrapperX<HrmAttendanceGroupDO>()
                .orderByDesc(HrmAttendanceGroupDO::getDefaultStatus)
                .orderByDesc(HrmAttendanceGroupDO::getId));
    }

}
