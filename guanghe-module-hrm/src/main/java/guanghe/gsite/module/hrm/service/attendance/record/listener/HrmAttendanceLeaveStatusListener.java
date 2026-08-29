package guanghe.gsite.module.hrm.service.attendance.record.listener;

import guanghe.gsite.module.bpm.api.event.BpmProcessInstanceStatusEvent;
import guanghe.gsite.module.bpm.api.event.BpmProcessInstanceStatusEventListener;
import guanghe.gsite.module.hrm.service.attendance.record.HrmAttendanceLeaveService;
import guanghe.gsite.module.hrm.service.attendance.record.HrmAttendanceLeaveServiceImpl;
import javax.annotation.Resource;
import org.springframework.stereotype.Component;

/**
 * HRM 请假审批状态监听器
 *
 * @author 光何
 */
@Component
public class HrmAttendanceLeaveStatusListener extends BpmProcessInstanceStatusEventListener {

    @Resource
    private HrmAttendanceLeaveService attendanceLeaveService;

    @Override
    protected String getProcessDefinitionKey() {
        return HrmAttendanceLeaveServiceImpl.LEAVE_PROCESS_KEY;
    }

    @Override
    protected void onEvent(BpmProcessInstanceStatusEvent event) {
        attendanceLeaveService.updateLeaveApprovalStatus(
                Long.parseLong(event.getBusinessKey()), event.getId(), event.getStatus(), event.getReason());
    }

}
