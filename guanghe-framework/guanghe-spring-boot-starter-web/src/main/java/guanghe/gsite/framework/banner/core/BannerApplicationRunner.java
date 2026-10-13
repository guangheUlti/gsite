package guanghe.gsite.framework.banner.core;

import cn.hutool.core.thread.ThreadUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.util.ClassUtils;

import java.util.concurrent.TimeUnit;

/**
 * 项目启动成功后，提供文档相关的地址
 *
 * @author 光何
 */
@Slf4j
public class BannerApplicationRunner implements ApplicationRunner {

    @Override
    public void run(ApplicationArguments args) {
        ThreadUtil.execute(() -> {
            ThreadUtil.sleep(1, TimeUnit.SECONDS); // 延迟 1 秒，保证输出到结尾
            log.info("\n----------------------------------------------------------\n\t" +
                            "项目启动成功！\n\t" +
                            "接口文档: \t{} \n\t" +
                            "开发文档: \t{} \n\t" +
                            "视频教程: \t{} \n" +
                            "----------------------------------------------------------",
                    "https://github.com/guangheUlti/gsite",
                    "https://github.com/guangheUlti/gsite",
                    "https://github.com/guangheUlti/gsite");

            // 商城系统
            if (isNotPresent("guanghe.gsite.module.trade.framework.web.config.TradeWebConfiguration")) {
                System.out.println("[商城系统 guanghe-module-mall - 已禁用][参考 https://github.com/guangheUlti/gsite 开启]");
            }
            // ERP 系统
            if (isNotPresent("guanghe.gsite.module.erp.framework.web.config.ErpWebConfiguration")) {
                System.out.println("[ERP 系统 guanghe-module-erp - 已禁用][参考 https://github.com/guangheUlti/gsite 开启]");
            }
            // WMS 仓库管理系统
            if (isNotPresent("guanghe.gsite.module.wms.framework.web.config.WmsWebConfiguration")) {
                System.out.println("[WMS 仓库管理系统 guanghe-module-wms - 已禁用][参考 https://github.com/guangheUlti/gsite 开启]");
            }
            // 支付平台
            if (isNotPresent("guanghe.gsite.module.pay.framework.pay.config.PayConfiguration")) {
                System.out.println("[支付系统 guanghe-module-pay - 已禁用][参考 https://github.com/guangheUlti/gsite 开启]");
            }
            // IM 即时通讯提示随模块裁剪移除
        });
    }

    private static boolean isNotPresent(String className) {
        return !ClassUtils.isPresent(className, ClassUtils.getDefaultClassLoader());
    }

}
