package guanghe.gsite.module.trade.framework.order.core.annotations;

import guanghe.gsite.module.trade.enums.order.TradeOrderOperateTypeEnum;
import guanghe.gsite.module.trade.framework.order.core.aop.TradeOrderLogAspect;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.METHOD;

/**
 * 交易订单的操作日志 AOP 注解
 *
 * @author 光何
 * @since 2023/7/6 15:37
 * @see TradeOrderLogAspect
 */
@Target({METHOD, ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface TradeOrderLog {

    /**
     * 操作类型
     */
    TradeOrderOperateTypeEnum operateType();

}
