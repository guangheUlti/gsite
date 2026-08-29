package guanghe.gsite.module.iot.dal.mysql.rule;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.iot.controller.admin.rule.vo.data.sink.IotDataSinkPageReqVO;
import guanghe.gsite.module.iot.dal.dataobject.rule.IotDataSinkDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * IoT 数据流转目的 Mapper
 *
 * @author 光何
 */
@Mapper
public interface IotDataSinkMapper extends BaseMapperX<IotDataSinkDO> {

    default PageResult<IotDataSinkDO> selectPage(IotDataSinkPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<IotDataSinkDO>()
                .likeIfPresent(IotDataSinkDO::getName, reqVO.getName())
                .eqIfPresent(IotDataSinkDO::getStatus, reqVO.getStatus())
                .eqIfPresent(IotDataSinkDO::getType, reqVO.getType())
                .betweenIfPresent(IotDataSinkDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(IotDataSinkDO::getId));
    }

    default List<IotDataSinkDO> selectListByStatus(Integer status) {
        return selectList(IotDataSinkDO::getStatus, status);
    }

    default IotDataSinkDO selectByName(String name) {
        return selectOne(IotDataSinkDO::getName, name);
    }

}