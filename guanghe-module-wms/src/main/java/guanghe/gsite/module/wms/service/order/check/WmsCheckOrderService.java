package guanghe.gsite.module.wms.service.order.check;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.module.wms.controller.admin.order.check.vo.order.WmsCheckOrderPageReqVO;
import guanghe.gsite.module.wms.controller.admin.order.check.vo.order.WmsCheckOrderSaveReqVO;
import guanghe.gsite.module.wms.dal.dataobject.order.check.WmsCheckOrderDO;

import javax.validation.Valid;

/**
 * WMS 盘库单 Service 接口
 *
 * @author 光何
 */
public interface WmsCheckOrderService {

    /**
     * 创建盘库单
     *
     * @param createReqVO 创建信息
     * @return 编号
     */
    Long createCheckOrder(@Valid WmsCheckOrderSaveReqVO createReqVO);

    /**
     * 更新盘库单
     *
     * @param updateReqVO 更新信息
     */
    void updateCheckOrder(@Valid WmsCheckOrderSaveReqVO updateReqVO);

    /**
     * 删除盘库单
     *
     * @param id 编号
     */
    void deleteCheckOrder(Long id);

    /**
     * 完成盘库
     *
     * @param id 编号
     */
    void completeCheckOrder(Long id);

    /**
     * 作废盘库单
     *
     * @param id 编号
     */
    void cancelCheckOrder(Long id);

    /**
     * 获得盘库单
     *
     * @param id 编号
     * @return 盘库单
     */
    WmsCheckOrderDO getCheckOrder(Long id);

    /**
     * 获得盘库单分页
     *
     * @param pageReqVO 分页查询
     * @return 盘库单分页
     */
    PageResult<WmsCheckOrderDO> getCheckOrderPage(WmsCheckOrderPageReqVO pageReqVO);

    /**
     * 获得指定仓库的盘库单数量
     *
     * @param warehouseId 仓库编号
     * @return 盘库单数量
     */
    long getCheckOrderCountByWarehouseId(Long warehouseId);

}
