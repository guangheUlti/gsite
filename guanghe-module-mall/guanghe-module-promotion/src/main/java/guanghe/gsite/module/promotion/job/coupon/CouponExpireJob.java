package guanghe.gsite.module.promotion.job.coupon;

import cn.hutool.core.util.StrUtil;
import guanghe.gsite.framework.quartz.core.handler.JobHandler;
import guanghe.gsite.framework.tenant.core.job.TenantJob;
import guanghe.gsite.module.promotion.service.coupon.CouponService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 优惠券过期 Job
 *
 * @author 光何
 */
@Component
public class CouponExpireJob implements JobHandler {

    @Resource
    private CouponService couponService;

    @Override
    @TenantJob
    public String execute(String param) {
        int count = couponService.expireCoupon();
        return StrUtil.format("过期优惠券 {} 个", count);
    }

}
