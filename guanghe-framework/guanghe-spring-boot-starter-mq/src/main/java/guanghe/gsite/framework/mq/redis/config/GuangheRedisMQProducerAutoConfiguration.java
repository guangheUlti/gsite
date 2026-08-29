package guanghe.gsite.framework.mq.redis.config;

import guanghe.gsite.framework.mq.redis.core.RedisMQTemplate;
import guanghe.gsite.framework.mq.redis.core.interceptor.RedisMessageInterceptor;
import guanghe.gsite.framework.redis.config.GuangheRedisAutoConfiguration;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.data.redis.core.StringRedisTemplate;

import java.util.List;

/**
 * Redis 消息队列 Producer 配置类
 *
 * @author 光何
 */
@Slf4j
@AutoConfiguration(after = GuangheRedisAutoConfiguration.class)
public class GuangheRedisMQProducerAutoConfiguration {

    @Bean
    public RedisMQTemplate redisMQTemplate(StringRedisTemplate redisTemplate,
                                           List<RedisMessageInterceptor> interceptors) {
        RedisMQTemplate redisMQTemplate = new RedisMQTemplate(redisTemplate);
        // 添加拦截器
        interceptors.forEach(redisMQTemplate::addInterceptor);
        return redisMQTemplate;
    }

}
