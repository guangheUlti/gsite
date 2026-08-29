package guanghe.gsite.module.trade.service.message;

import guanghe.gsite.module.system.api.notify.NotifyMessageSendApi;
import guanghe.gsite.module.system.api.notify.dto.NotifySendSingleToUserReqDTO;
import guanghe.gsite.module.trade.enums.MessageTemplateConstants;
import guanghe.gsite.module.trade.service.message.bo.TradeOrderMessageWhenDeliveryOrderReqBO;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * Trade 消息 service 实现类
 *
 * @author 光何
 */
@Service
@Validated
public class TradeMessageServiceImpl implements TradeMessageService {

    @Resource
    private NotifyMessageSendApi notifyMessageSendApi;

    @Override
    public void sendMessageWhenDeliveryOrder(TradeOrderMessageWhenDeliveryOrderReqBO reqBO) {
        if (true) {
            return;
        }
        // 1、构造消息
        Map<String, Object> msgMap = new HashMap<>(2);
        msgMap.put("orderId", reqBO.getOrderId());
        msgMap.put("deliveryMessage", reqBO.getMessage());
        // TODO 光何：看下模版
        // 2、发送站内信
        notifyMessageSendApi.sendSingleMessageToMember(
                new NotifySendSingleToUserReqDTO()
                        .setUserId(reqBO.getUserId())
                        .setTemplateCode(MessageTemplateConstants.SMS_ORDER_DELIVERY)
                        .setTemplateParams(msgMap));
    }

}
