package guanghe.gsite.module.hrm.service.employee.info;

import guanghe.gsite.module.hrm.controller.admin.employee.vo.file.HrmEmployeeFileSaveReqVO;
import guanghe.gsite.module.hrm.dal.dataobject.employee.info.HrmEmployeeFileDO;

import java.util.List;

/**
 * HRM 员工材料附件 Service 接口
 *
 * @author 光何
 */
public interface HrmEmployeeFileService {

    /**
     * 保存员工指定类型的材料附件
     *
     * @param reqVO 附件信息
     */
    void saveEmployeeFiles(HrmEmployeeFileSaveReqVO reqVO);

    /**
     * 获得员工材料附件列表
     *
     * @param employeeId 员工编号
     * @return 材料附件列表
     */
    List<HrmEmployeeFileDO> getEmployeeFileList(Long employeeId);

}
