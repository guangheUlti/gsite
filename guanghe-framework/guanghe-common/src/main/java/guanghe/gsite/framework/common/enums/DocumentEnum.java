package guanghe.gsite.framework.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 文档地址
 *
 * @author 光何
 */
@Getter
@AllArgsConstructor
public enum DocumentEnum {

    REDIS_INSTALL("https://github.com/guangheUlti/gsite", "Redis 安装文档"),
    TENANT("https://github.com/guangheUlti/gsite", "SaaS 多租户文档");

    private final String url;
    private final String memo;

}
