package guanghe.gsite.module.pay.service.transfer;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.module.pay.framework.pay.core.client.dto.transfer.PayTransferRespDTO;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferCreateReqDTO;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferCreateRespDTO;
import guanghe.gsite.module.pay.controller.admin.transfer.vo.PayTransferPageReqVO;
import guanghe.gsite.module.pay.dal.dataobject.transfer.PayTransferDO;
import javax.validation.Valid;

/**
 * 转账 Service 接口
 *
 * @author 光何
 */
public interface PayTransferService {

    /**
     * 创建转账单，并发起转账
     *
     * @param reqDTO 创建请求
     * @return 转账单编号
     */
    PayTransferCreateRespDTO createTransfer(@Valid PayTransferCreateReqDTO reqDTO);

    /**
     * 获取转账单
     * @param id 转账单编号
     */
    PayTransferDO getTransfer(Long id);

    /**
     * 根据转账单号获取转账单
     *
     * @param no 转账单号
     * @return 转账单
     */
    PayTransferDO getTransferByNo(String no);

    /**
     * 获得转账单分页
     *
     * @param pageReqVO 分页查询
     * @return 转账单分页
     */
    PageResult<PayTransferDO> getTransferPage(PayTransferPageReqVO pageReqVO);

    /**
     * 同步渠道转账单状态
     *
     * @return 同步到状态的转账数量，包括转账成功、转账失败、转账中的
     */
    int syncTransfer();

    /**
     * 【单个】同步渠道转账单状态
     *
     * @param id 转账单编号
     */
    void syncTransfer(Long id);

    /**
     * 渠道的转账通知
     *
     * @param channelId  渠道编号
     * @param notify     通知
     */
    void notifyTransfer(Long channelId, PayTransferRespDTO notify);

}
