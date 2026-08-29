package guanghe.gsite.module.infra.service.systemupdate;

import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateStatusRespVO;
import guanghe.gsite.module.infra.controller.admin.systemupdate.vo.SystemUpdateUploadRespVO;
import org.springframework.web.multipart.MultipartFile;

public interface SystemUpdateService {

    /**
     * 校验并暂存上传的更新包
     */
    SystemUpdateUploadRespVO validateAndStage(MultipartFile file, String type);

    /**
     * 应用已暂存的更新（后端、前端或两者）
     */
    void applyUpdate(String backendTempPath, String frontendTempPath);

    /**
     * 回滚到指定备份
     */
    void rollback(String backupTimestamp);

    /**
     * 获取当前更新状态与可用备份列表
     */
    SystemUpdateStatusRespVO getStatus();

}
