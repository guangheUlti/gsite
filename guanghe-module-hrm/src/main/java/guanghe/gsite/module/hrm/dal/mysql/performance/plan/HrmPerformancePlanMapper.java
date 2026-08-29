package guanghe.gsite.module.hrm.dal.mysql.performance.plan;

import cn.hutool.core.map.MapUtil;
import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.common.util.collection.CollectionUtils;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.framework.mybatis.core.query.QueryWrapperX;
import guanghe.gsite.module.hrm.controller.admin.performance.vo.plan.HrmPerformancePlanPageReqVO;
import guanghe.gsite.module.hrm.dal.dataobject.performance.plan.HrmPerformancePlanDO;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface HrmPerformancePlanMapper extends BaseMapperX<HrmPerformancePlanDO> {

    default PageResult<HrmPerformancePlanDO> selectPage(HrmPerformancePlanPageReqVO reqVO) {
        return selectPage(reqVO, buildQueryWrapper(reqVO)
                .eqIfPresent("status", reqVO.getStatus())
                .orderByDesc("id"));
    }

    default Map<Integer, Long> selectCountMapByStatus(HrmPerformancePlanPageReqVO reqVO) {
        QueryWrapperX<HrmPerformancePlanDO> query = buildQueryWrapper(reqVO);
        query.select("status", "COUNT(id) AS count").groupBy("status");
        return CollectionUtils.convertMap(selectMaps(query),
                record -> MapUtil.getInt(record, "status"),
                record -> MapUtil.getLong(record, "count"));
    }

    default HrmPerformancePlanDO selectByName(String name) {
        return selectFirstOne(HrmPerformancePlanDO::getName, name);
    }

    default List<HrmPerformancePlanDO> selectListByPaidForMonth(String paidForMonth) {
        return selectList(new LambdaQueryWrapperX<HrmPerformancePlanDO>()
                .eq(HrmPerformancePlanDO::getPaidForMonth, paidForMonth)
                .orderByDesc(HrmPerformancePlanDO::getId));
    }

    @SuppressWarnings("UnusedReturnValue")
    default int updateStageTypeAndOperationTypeById(Long id, Integer stageType, Integer operationType) {
        return update(new LambdaUpdateWrapper<HrmPerformancePlanDO>()
                .set(HrmPerformancePlanDO::getStageType, stageType)
                .set(HrmPerformancePlanDO::getOperationType, operationType)
                .eq(HrmPerformancePlanDO::getId, id));
    }

    static QueryWrapperX<HrmPerformancePlanDO> buildQueryWrapper(HrmPerformancePlanPageReqVO reqVO) {
        return new QueryWrapperX<HrmPerformancePlanDO>()
                .likeIfPresent("name", reqVO.getName())
                .eqIfPresent("stage_type", reqVO.getStageType());
    }

}
