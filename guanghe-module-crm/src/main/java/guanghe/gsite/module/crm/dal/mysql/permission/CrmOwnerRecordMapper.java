package guanghe.gsite.module.crm.dal.mysql.permission;

import guanghe.gsite.framework.mybatis.core.mapper.BaseMapperX;
import guanghe.gsite.module.crm.controller.admin.statistics.vo.customer.CrmStatisticsCustomerReqVO;
import guanghe.gsite.module.crm.controller.admin.statistics.vo.customer.CrmStatisticsPoolSummaryByDateRespVO;
import guanghe.gsite.module.crm.controller.admin.statistics.vo.customer.CrmStatisticsPoolSummaryByUserRespVO;
import guanghe.gsite.module.crm.dal.dataobject.permission.CrmOwnerRecordDO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * CRM 负责人变更记录 Mapper
 *
 * @author 光何
 */
@Mapper
public interface CrmOwnerRecordMapper extends BaseMapperX<CrmOwnerRecordDO> {

    /**
     * 进入公海客户数(按日期)
     *
     * @param reqVO 请求参数
     * @return 统计数据
     */
    List<CrmStatisticsPoolSummaryByDateRespVO> selectPoolCustomerPutCountByDate(CrmStatisticsCustomerReqVO reqVO);

    /**
     * 公海领取客户数(按日期)
     *
     * @param reqVO 请求参数
     * @return 统计数据
     */
    List<CrmStatisticsPoolSummaryByDateRespVO> selectPoolCustomerTakeCountByDate(CrmStatisticsCustomerReqVO reqVO);

    /**
     * 进入公海客户数(按用户)
     *
     * @param reqVO 请求参数
     * @return 统计数据
     */
    List<CrmStatisticsPoolSummaryByUserRespVO> selectPoolCustomerPutCountByUser(CrmStatisticsCustomerReqVO reqVO);

    /**
     * 公海领取客户数(按用户)
     *
     * @param reqVO 请求参数
     * @return 统计数据
     */
    List<CrmStatisticsPoolSummaryByUserRespVO> selectPoolCustomerTakeCountByUser(CrmStatisticsCustomerReqVO reqVO);

}
