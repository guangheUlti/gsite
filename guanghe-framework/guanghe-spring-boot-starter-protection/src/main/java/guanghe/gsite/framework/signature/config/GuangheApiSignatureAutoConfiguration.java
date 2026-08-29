package guanghe.gsite.framework.signature.config;

import guanghe.gsite.framework.redis.config.GuangheRedisAutoConfiguration;
import guanghe.gsite.framework.signature.core.aop.ApiSignatureAspect;
import guanghe.gsite.framework.signature.core.redis.ApiSignatureRedisDAO;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.StringRedisTemplate;

/**
 * HTTP API 签名的自动配置类
 *
 * @author 光何
 */
@AutoConfiguration(after = GuangheRedisAutoConfiguration.class)
public class GuangheApiSignatureAutoConfiguration {

    @Bean
    public ApiSignatureAspect signatureAspect(ApiSignatureRedisDAO signatureRedisDAO) {
        return new ApiSignatureAspect(signatureRedisDAO);
    }

    @Bean
    public ApiSignatureRedisDAO signatureRedisDAO(StringRedisTemplate stringRedisTemplate) {
        return new ApiSignatureRedisDAO(stringRedisTemplate);
    }

}
