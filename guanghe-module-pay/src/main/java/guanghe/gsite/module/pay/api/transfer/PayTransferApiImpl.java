package guanghe.gsite.module.pay.api.transfer;

import guanghe.gsite.framework.common.util.object.BeanUtils;
import guanghe.gsite.module.pay.framework.pay.core.client.impl.weixin.WxPayClientConfig;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferCreateReqDTO;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferCreateRespDTO;
import guanghe.gsite.module.pay.api.transfer.dto.PayTransferRespDTO;
import guanghe.gsite.module.pay.dal.dataobject.channel.PayChannelDO;
import guanghe.gsite.module.pay.dal.dataobject.transfer.PayTransferDO;
import guanghe.gsite.module.pay.service.channel.PayChannelService;
import guanghe.gsite.module.pay.service.transfer.PayTransferService;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;

/**
 * 转账单 API 实现类
 *
 * @author 光何
 */
@Service
@Validated
public class PayTransferApiImpl implements PayTransferApi {

    @Resource
    private PayTransferService payTransferService;
    @Resource
    private PayChannelService payChannelService;

    @Override
    public PayTransferCreateRespDTO createTransfer(PayTransferCreateReqDTO reqDTO) {
        return payTransferService.createTransfer(reqDTO);
    }

    @Override
    public PayTransferRespDTO getTransfer(Long id) {
        PayTransferDO transfer = payTransferService.getTransfer(id);
        if (transfer == null) {
            return null;
        }
        PayChannelDO channel = payChannelService.getChannel(transfer.getChannelId());
        String mchId = null;
        if (channel != null && channel.getConfig() instanceof WxPayClientConfig) {
            mchId = ((WxPayClientConfig) channel.getConfig()).getMchId();
        }
        return BeanUtils.toBean(transfer, PayTransferRespDTO.class).setChannelMchId(mchId);
    }

}
