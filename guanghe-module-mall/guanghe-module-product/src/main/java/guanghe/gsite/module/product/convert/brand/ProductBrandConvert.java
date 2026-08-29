package guanghe.gsite.module.product.convert.brand;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.module.product.controller.admin.brand.vo.ProductBrandCreateReqVO;
import guanghe.gsite.module.product.controller.admin.brand.vo.ProductBrandRespVO;
import guanghe.gsite.module.product.controller.admin.brand.vo.ProductBrandSimpleRespVO;
import guanghe.gsite.module.product.controller.admin.brand.vo.ProductBrandUpdateReqVO;
import guanghe.gsite.module.product.dal.dataobject.brand.ProductBrandDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 品牌 Convert
 *
 * @author 光何
 */
@Mapper
public interface ProductBrandConvert {

    ProductBrandConvert INSTANCE = Mappers.getMapper(ProductBrandConvert.class);

    ProductBrandDO convert(ProductBrandCreateReqVO bean);

    ProductBrandDO convert(ProductBrandUpdateReqVO bean);

    ProductBrandRespVO convert(ProductBrandDO bean);

    List<ProductBrandSimpleRespVO> convertList1(List<ProductBrandDO> list);

    List<ProductBrandRespVO> convertList(List<ProductBrandDO> list);

    PageResult<ProductBrandRespVO> convertPage(PageResult<ProductBrandDO> page);

}
