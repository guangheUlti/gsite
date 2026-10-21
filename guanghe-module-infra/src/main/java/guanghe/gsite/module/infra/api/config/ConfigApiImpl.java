package guanghe.gsite.module.infra.api.config;

import guanghe.gsite.module.infra.dal.dataobject.config.ConfigDO;
import guanghe.gsite.module.infra.service.config.ConfigService;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import jakarta.annotation.Resource;

/**
 * 参数配置 API 实现类
 *
 * @author 光何
 */
@Service
@Validated
public class ConfigApiImpl implements ConfigApi {

    @Resource
    private ConfigService configService;

    @Override
    public String getConfigValueByKey(String key) {
        ConfigDO config = configService.getConfigByKey(key);
        return config != null ? config.getValue() : null;
    }

}
