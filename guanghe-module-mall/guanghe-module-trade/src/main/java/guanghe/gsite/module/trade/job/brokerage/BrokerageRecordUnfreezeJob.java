package guanghe.gsite.module.trade.job.brokerage;

import cn.hutool.core.util.StrUtil;
import guanghe.gsite.framework.quartz.core.handler.JobHandler;
import guanghe.gsite.framework.tenant.core.job.TenantJob;
import guanghe.gsite.module.trade.service.brokerage.BrokerageRecordService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 佣金解冻 Job
 *
 * @author 光何
 */
@Component
public class BrokerageRecordUnfreezeJob implements JobHandler {

    @Resource
    private BrokerageRecordService brokerageRecordService;

    @Override
    @TenantJob
    public String execute(String param) {
        int count = brokerageRecordService.unfreezeRecord();
        return StrUtil.format("解冻佣金 {} 个", count);
    }

}
