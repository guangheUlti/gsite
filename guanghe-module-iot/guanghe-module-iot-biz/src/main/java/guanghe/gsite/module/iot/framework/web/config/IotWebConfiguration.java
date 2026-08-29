package guanghe.gsite.module.iot.framework.web.config;

import guanghe.gsite.framework.swagger.config.GuangheSwaggerAutoConfiguration;
import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * iot 模块的 web 组件的 Configuration
 *
 * @author 光何
 */
@Configuration(proxyBeanMethods = false)
public class IotWebConfiguration {

    /**
     * iot 模块的 API 分组
     */
    @Bean
    public GroupedOpenApi iotGroupedOpenApi() {
        return GuangheSwaggerAutoConfiguration.buildGroupedOpenApi("iot");
    }

}
