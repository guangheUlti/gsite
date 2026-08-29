package guanghe.gsite.module.wms.dal.mysql.md.merchant;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.framework.mybatis.core.query.LambdaQueryWrapperX;
import guanghe.gsite.module.wms.controller.admin.md.merchant.vo.WmsMerchantListReqVO;
import guanghe.gsite.module.wms.controller.admin.md.merchant.vo.WmsMerchantPageReqVO;
import guanghe.gsite.module.wms.dal.dataobject.md.merchant.WmsMerchantDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * WMS 往来企业 Mapper
 *
 * @author 光何
 */
@Mapper
public interface WmsMerchantMapper extends BaseMapperX<WmsMerchantDO> {

    default PageResult<WmsMerchantDO> selectPage(WmsMerchantPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<WmsMerchantDO>()
                .eqIfPresent(WmsMerchantDO::getCode, reqVO.getCode())
                .likeIfPresent(WmsMerchantDO::getName, reqVO.getName())
                .eqIfPresent(WmsMerchantDO::getType, reqVO.getType())
                .inIfPresent(WmsMerchantDO::getType, reqVO.getTypes())
                .orderByDesc(WmsMerchantDO::getId));
    }

    default List<WmsMerchantDO> selectList(WmsMerchantListReqVO reqVO) {
        return selectList(new LambdaQueryWrapperX<WmsMerchantDO>()
                .eqIfPresent(WmsMerchantDO::getCode, reqVO.getCode())
                .likeIfPresent(WmsMerchantDO::getName, reqVO.getName())
                .eqIfPresent(WmsMerchantDO::getType, reqVO.getType())
                .inIfPresent(WmsMerchantDO::getType, reqVO.getTypes())
                .orderByDesc(WmsMerchantDO::getId));
    }

    default WmsMerchantDO selectByCode(String code) {
        return selectOne(WmsMerchantDO::getCode, code);
    }

    default WmsMerchantDO selectByName(String name) {
        return selectOne(WmsMerchantDO::getName, name);
    }

}
