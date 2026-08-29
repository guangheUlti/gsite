package guanghe.gsite.module.crm.service.contract.listener;

import guanghe.gsite.module.bpm.api.event.BpmProcessInstanceStatusEvent;
import guanghe.gsite.module.bpm.api.event.BpmProcessInstanceStatusEventListener;
import guanghe.gsite.module.crm.service.contract.CrmContractService;
import guanghe.gsite.module.crm.service.contract.CrmContractServiceImpl;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * 合同审批的结果的监听器实现类
 *
 * @author 光何
 */
@Component
public class CrmContractStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private CrmContractService contractService;

    @Override
    public String getProcessDefinitionKey() {
        return CrmContractServiceImpl.BPM_PROCESS_DEFINITION_KEY;
    }

    @Override
    protected void onEvent(BpmProcessInstanceStatusEvent event) {
        contractService.updateContractAuditStatus(Long.parseLong(event.getBusinessKey()), event.getStatus());
    }

}
