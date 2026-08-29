package guanghe.gsite.module.trade.convert.config;

import guanghe.gsite.module.trade.controller.admin.config.vo.TradeConfigRespVO;
import guanghe.gsite.module.trade.controller.admin.config.vo.TradeConfigSaveReqVO;
import guanghe.gsite.module.trade.controller.app.config.vo.AppTradeConfigRespVO;
import guanghe.gsite.module.trade.dal.dataobject.config.TradeConfigDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * 交易中心配置 Convert
 *
 * @author 光何
 */
@Mapper
public interface TradeConfigConvert {

    TradeConfigConvert INSTANCE = Mappers.getMapper(TradeConfigConvert.class);

    TradeConfigDO convert(TradeConfigSaveReqVO bean);

    TradeConfigRespVO convert(TradeConfigDO bean);

    AppTradeConfigRespVO convert02(TradeConfigDO tradeConfig);
}
