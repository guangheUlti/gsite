package guanghe.gsite.module.fms.dal.mysql.report;

import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.fms.dal.dataobject.report.FmsReportTemplateDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * FMS 报表模板 Mapper
 *
 * @author 光何
 */
@Mapper
public interface FmsReportTemplateMapper extends BaseMapperX<FmsReportTemplateDO> {

    default List<FmsReportTemplateDO> selectListByType(Integer type) {
        return selectList(new LambdaQueryWrapperX<FmsReportTemplateDO>()
                .eq(FmsReportTemplateDO::getType, type)
                .orderByAsc(FmsReportTemplateDO::getSort)
                .orderByAsc(FmsReportTemplateDO::getId));
    }

}
