package guanghe.gsite.module.pay.convert.wallet;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.module.pay.controller.admin.wallet.vo.transaction.PayWalletTransactionRespVO;
import guanghe.gsite.module.pay.controller.app.wallet.vo.transaction.AppPayWalletTransactionRespVO;
import guanghe.gsite.module.pay.dal.dataobject.wallet.PayWalletTransactionDO;
import guanghe.gsite.module.pay.service.wallet.bo.WalletTransactionCreateReqBO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PayWalletTransactionConvert {

    PayWalletTransactionConvert INSTANCE = Mappers.getMapper(PayWalletTransactionConvert.class);

    PageResult<PayWalletTransactionRespVO> convertPage2(PageResult<PayWalletTransactionDO> page);

    PayWalletTransactionDO convert(WalletTransactionCreateReqBO bean);

}
