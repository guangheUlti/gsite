package guanghe.gsite.module.pay.api.transfer;

import guanghe.gsite.module.pay.api.transfer.dto.PayTransferCreateReqDTO;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferCreateRespDTO;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferRespDTO;
import javax.validation.Valid;

/**
 * 转账单 API 接口
 *
 * @author 光何
 */
public interface PayTransferApi {

    /**
     * 创建转账单
     *
     * @param reqDTO 创建请求
     * @return 创建结果
     */
    PayTransferCreateRespDTO createTransfer(@Valid PayTransferCreateReqDTO reqDTO);

    /**
     * 获得转账单
     *
     * @param id 转账单编号
     * @return 转账单
     */
    PayTransferRespDTO getTransfer(Long id);

}
