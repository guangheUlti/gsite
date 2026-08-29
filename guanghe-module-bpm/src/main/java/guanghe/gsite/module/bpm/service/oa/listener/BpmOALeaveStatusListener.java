package guanghe.gsite.module.bpm.service.oa.listener;

import guanghe.gsite.module.bpm.api.event.BpmProcessInstanceStatusEvent;
import guanghe.gsite.module.bpm.api.event.BpmProcessInstanceStatusEventListener;
import guanghe.gsite.module.bpm.service.oa.BpmOALeaveService;
import guanghe.gsite.module.bpm.service.oa.BpmOALeaveServiceImpl;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * OA 请假单的结果的监听器实现类
 *
 * @author 光何
 */
@Component
public class BpmOALeaveStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private BpmOALeaveService leaveService;

    @Override
    protected String getProcessDefinitionKey() {
        return BpmOALeaveServiceImpl.PROCESS_KEY;
    }

    @Override
    protected void onEvent(BpmProcessInstanceStatusEvent event) {
        leaveService.updateLeaveStatus(Long.parseLong(event.getBusinessKey()), event.getStatus());
    }

}
