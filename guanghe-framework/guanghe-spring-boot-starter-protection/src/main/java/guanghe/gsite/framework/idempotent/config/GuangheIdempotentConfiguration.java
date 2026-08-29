package guanghe.gsite.framework.idempotent.config;

import guanghe.gsite.framework.idempotent.core.aop.IdempotentAspect;
import guanghe.gsite.framework.idempotent.core.keyresolver.impl.DefaultIdempotentKeyResolver;
import guanghe.gsite.framework.idempotent.core.keyresolver.impl.ExpressionIdempotentKeyResolver;
import guanghe.gsite.framework.idempotent.core.keyresolver.IdempotentKeyResolver;
import guanghe.gsite.framework.idempotent.core.keyresolver.impl.UserIdempotentKeyResolver;
import guanghe.gsite.framework.idempotent.core.redis.IdempotentRedisDAO;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import guanghe.gsite.framework.redis.config.GuangheRedisAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.List;

@AutoConfiguration(after = GuangheRedisAutoConfiguration.class)
public class GuangheIdempotentConfiguration {

    @Bean
    public IdempotentAspect idempotentAspect(List<IdempotentKeyResolver> keyResolvers, IdempotentRedisDAO idempotentRedisDAO) {
        return new IdempotentAspect(keyResolvers, idempotentRedisDAO);
    }

    @Bean
    public IdempotentRedisDAO idempotentRedisDAO(StringRedisTemplate stringRedisTemplate) {
        return new IdempotentRedisDAO(stringRedisTemplate);
    }

    // ========== 各种 IdempotentKeyResolver Bean ==========

    @Bean
    public DefaultIdempotentKeyResolver defaultIdempotentKeyResolver() {
        return new DefaultIdempotentKeyResolver();
    }

    @Bean
    public UserIdempotentKeyResolver userIdempotentKeyResolver() {
        return new UserIdempotentKeyResolver();
    }

    @Bean
    public ExpressionIdempotentKeyResolver expressionIdempotentKeyResolver() {
        return new ExpressionIdempotentKeyResolver();
    }

}
