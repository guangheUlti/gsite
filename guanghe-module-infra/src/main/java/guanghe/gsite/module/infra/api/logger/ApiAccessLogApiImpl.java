package guanghe.gsite.module.infra.api.logger;

import guanghe.gsite.framework.common.biz.infra.logger.ApiAccessLogCommonApi;
import guanghe.gsite.framework.common.biz.infra.logger.dto.ApiAccessLogCreateReqDTO;
import guanghe.gsite.module.infra.service.logger.ApiAccessLogService;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;

/**
 * API 访问日志的 API 实现类
 *
 * @author 光何
 */
@Service
@Validated
public class ApiAccessLogApiImpl implements ApiAccessLogCommonApi {

    @Resource
    private ApiAccessLogService apiAccessLogService;

    @Override
    public void createApiAccessLog(ApiAccessLogCreateReqDTO createDTO) {
        apiAccessLogService.createApiAccessLog(createDTO);
    }

}
