package guanghe.gsite.module.infra.dal.mysql.db;

import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.module.infra.dal.dataobject.db.DataSourceConfigDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 数据源配置 Mapper
 *
 * @author 光何
 */
@Mapper
public interface DataSourceConfigMapper extends BaseMapperX<DataSourceConfigDO> {
}
