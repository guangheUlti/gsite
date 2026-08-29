package guanghe.gsite.module.pay.convert.wallet;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.module.pay.controller.admin.wallet.vo.wallet.PayWalletRespVO;
import guanghe.gsite.module.pay.controller.app.wallet.vo.wallet.AppPayWalletRespVO;
import guanghe.gsite.module.pay.dal.dataobject.wallet.PayWalletDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PayWalletConvert {

    PayWalletConvert INSTANCE = Mappers.getMapper(PayWalletConvert.class);

    AppPayWalletRespVO convert(PayWalletDO bean);

    PayWalletRespVO convert02(PayWalletDO bean);

    PageResult<PayWalletRespVO> convertPage(PageResult<PayWalletDO> page);

}
