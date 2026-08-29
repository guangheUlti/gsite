package guanghe.gsite.module.infra.framework.file.config;

import guanghe.gsite.module.infra.framework.file.core.client.FileClientFactory;
import guanghe.gsite.module.infra.framework.file.core.client.FileClientFactoryImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 文件配置类
 *
 * @author 光何
 */
@Configuration(proxyBeanMethods = false)
public class GuangheFileAutoConfiguration {

    @Bean
    public FileClientFactory fileClientFactory() {
        return new FileClientFactoryImpl();
    }

}
