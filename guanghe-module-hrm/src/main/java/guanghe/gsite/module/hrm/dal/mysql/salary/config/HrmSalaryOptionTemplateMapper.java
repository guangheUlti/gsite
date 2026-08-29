package guanghe.gsite.module.hrm.dal.mysql.salary.config;

import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.hrm.dal.dataobject.salary.config.HrmSalaryOptionTemplateDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface HrmSalaryOptionTemplateMapper extends BaseMapperX<HrmSalaryOptionTemplateDO> {

    default List<HrmSalaryOptionTemplateDO> selectListOrderByCode() {
        return selectList(new LambdaQueryWrapperX<HrmSalaryOptionTemplateDO>()
                .orderByAsc(HrmSalaryOptionTemplateDO::getCode));
    }

}
