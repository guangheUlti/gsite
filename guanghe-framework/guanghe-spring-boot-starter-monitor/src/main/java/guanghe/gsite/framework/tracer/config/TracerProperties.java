package guanghe.gsite.framework.tracer.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * BizTracer配置类
 *
 * @author 光何
 */
@ConfigurationProperties("guanghe.tracer")
@Data
public class TracerProperties {
}
