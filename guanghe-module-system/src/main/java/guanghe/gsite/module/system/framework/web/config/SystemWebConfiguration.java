package guanghe.gsite.module.system.framework.web.config;

import guanghe.gsite.framework.swagger.config.GuangheSwaggerAutoConfiguration;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * system 模块的 web 组件的 Configuration
 *
 * @author 光何
 */
@Configuration(proxyBeanMethods = false)
public class SystemWebConfiguration {

    /**
     * system 模块的 API 分组
     */
    @Bean
    public GroupedOpenApi systemGroupedOpenApi() {
        return GuangheSwaggerAutoConfiguration.buildGroupedOpenApi("system");
    }

}
