package guanghe.gsite.module.trade.convert.aftersale;

import guanghe.gsite.module.trade.dal.dataobject.aftersale.AfterSaleLogDO;
import guanghe.gsite.module.trade.service.aftersale.bo.AfterSaleLogCreateReqBO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface AfterSaleLogConvert {

    AfterSaleLogConvert INSTANCE = Mappers.getMapper(AfterSaleLogConvert.class);

    AfterSaleLogDO convert(AfterSaleLogCreateReqBO bean);

}
