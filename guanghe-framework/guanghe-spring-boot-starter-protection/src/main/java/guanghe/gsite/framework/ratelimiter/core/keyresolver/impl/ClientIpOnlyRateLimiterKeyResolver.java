package guanghe.gsite.framework.ratelimiter.core.keyresolver.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import guanghe.gsite.framework.common.util.servlet.ServletUtils;
import guanghe.gsite.framework.ratelimiter.core.annotation.RateLimiter;
import guanghe.gsite.framework.ratelimiter.core.keyresolver.RateLimiterKeyResolver;
import org.aspectj.lang.JoinPoint;

import javax.servlet.http.HttpServletRequest;

/**
 * 客户端 IP 级别的限流 Key 解析器，使用方法名 + IP 组装成一个 Key
 *
 * 与 {@link ClientIpRateLimiterKeyResolver} 的区别有两点：
 * 1. 刻意不包含方法参数。匿名接口（如注册）的参数每次都不同，若把参数拼进 Key，
 *    攻击者不断变换参数即可拿到新 Key，限流被完全绕过。
 * 2. IP 的取值不信任 {@code X-Forwarded-For}。该头常用 {@code $proxy_add_x_forwarded_for}
 *    追加生成，第一段仍是客户端可控内容；这里只在与本机反向代理直连时，
 *    才采用代理用 {@code $remote_addr} 强制覆写的 {@code X-Real-IP}。
 *
 * @author 光何
 */
public class ClientIpOnlyRateLimiterKeyResolver implements RateLimiterKeyResolver {

    @Override
    public String resolver(JoinPoint joinPoint, RateLimiter rateLimiter) {
        String methodName = joinPoint.getSignature().toString();
        return SecureUtil.md5(methodName + resolveClientIp());
    }

    /**
     * 获得可信的客户端 IP
     *
     * @return 客户端 IP，无法识别时返回 unknown
     */
    private static String resolveClientIp() {
        HttpServletRequest request = ServletUtils.getRequest();
        if (request == null) {
            return "unknown";
        }
        String remoteAddr = request.getRemoteAddr();
        // 仅当直连来源是本机（反向代理与应用同机部署）时，才信任代理写入的 X-Real-IP
        if (isLocal(remoteAddr)) {
            String realIp = request.getHeader("X-Real-IP");
            if (StrUtil.isNotBlank(realIp)) {
                return realIp;
            }
        }
        return StrUtil.blankToDefault(remoteAddr, "unknown");
    }

    private static boolean isLocal(String ip) {
        return "127.0.0.1".equals(ip) || "0:0:0:0:0:0:0:1".equals(ip) || "::1".equals(ip);
    }

}
