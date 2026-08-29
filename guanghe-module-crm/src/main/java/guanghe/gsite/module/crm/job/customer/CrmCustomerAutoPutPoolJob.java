package guanghe.gsite.module.crm.job.customer;

import guanghe.gsite.framework.quartz.core.handler.JobHandler;
import guanghe.gsite.framework.tenant.core.job.TenantJob;
import guanghe.gsite.module.crm.service.customer.CrmCustomerService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 客户自动掉入公海 Job
 *
 * @author 光何
 */
@Component
public class CrmCustomerAutoPutPoolJob implements JobHandler {

    @Resource
    private CrmCustomerService customerService;

    @Override
    @TenantJob
    public String execute(String param) {
        int count = customerService.autoPutCustomerPool();
        return String.format("掉入公海客户 %s 个", count);
    }

}