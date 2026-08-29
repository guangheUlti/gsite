package guanghe.gsite.module.infra.framework.web.config;

import guanghe.gsite.framework.swagger.config.GuangheSwaggerAutoConfiguration;
import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * infra 模块的 web 组件的 Configuration
 *
 * @author 光何
 */
@Configuration(proxyBeanMethods = false)
public class InfraWebConfiguration {

    /**
     * infra 模块的 API 分组
     */
    @Bean
    public GroupedOpenApi infraGroupedOpenApi() {
        return GuangheSwaggerAutoConfiguration.buildGroupedOpenApi("infra");
    }

}
