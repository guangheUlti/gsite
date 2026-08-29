package guanghe.gsite.module.trade.framework.delivery.core.client.dto;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 快递查询的轨迹 Resp DTO
 *
 * @author 光何
 */
@Data
public class ExpressTrackRespDTO {

    /**
     * 发生时间
     */
    private LocalDateTime time;

    /**
     * 快递状态
     */
    private String content;

}
