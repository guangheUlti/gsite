package guanghe.gsite.module.promotion.api.discount;

import guanghe.gsite.framework.common.util.object.BeanUtils;
import guanghe.gsite.module.promotion.api.discount.dto.DiscountProductRespDTO;
import guanghe.gsite.module.promotion.dal.dataobject.discount.DiscountProductDO;
import guanghe.gsite.module.promotion.service.discount.DiscountActivityService;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;

/**
 * 限时折扣 API 实现类
 *
 * @author 光何
 */
@Service
@Validated
public class DiscountActivityApiImpl implements DiscountActivityApi {

    @Resource
    private DiscountActivityService discountActivityService;

    @Override
    public List<DiscountProductRespDTO> getMatchDiscountProductListBySkuIds(Collection<Long> skuIds) {
        List<DiscountProductDO> list = discountActivityService.getMatchDiscountProductListBySkuIds(skuIds);
        return BeanUtils.toBean(list, DiscountProductRespDTO.class);
    }

}
