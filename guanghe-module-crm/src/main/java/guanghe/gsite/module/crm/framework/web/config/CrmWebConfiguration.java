package guanghe.gsite.module.crm.framework.web.config;

import guanghe.gsite.framework.swagger.config.GuangheSwaggerAutoConfiguration;
import org.springdoc.core.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * crm 模块的 web 组件的 Configuration
 *
 * @author 光何
 */
@Configuration(proxyBeanMethods = false)
public class CrmWebConfiguration {

    /**
     * crm 模块的 API 分组
     */
    @Bean
    public GroupedOpenApi crmGroupedOpenApi() {
        return GuangheSwaggerAutoConfiguration.buildGroupedOpenApi("crm");
    }

}
