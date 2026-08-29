package guanghe.gsite.module.mes.enums.wm;

import guanghe.gsite.framework.common.core.ArrayValuable;
import guanghe.gsite.module.mes.enums.MesOrderStatusConstants;
import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;

/**
 * MES 装箱单状态枚举
 *
 * @author 光何
 */
@Getter
@AllArgsConstructor
public enum MesWmPackageStatusEnum implements ArrayValuable<Integer> {

    /**
     * 草稿
     *
     * 对应 MesWmPackageService#createPackage 方法
     */
    PREPARE(MesOrderStatusConstants.PREPARE, "草稿"),
    /**
     * 已完成
     *
     * 对应 MesWmPackageService#finishPackage 方法
     */
    FINISHED(MesOrderStatusConstants.FINISHED, "已完成");

    public static final Integer[] ARRAYS = Arrays.stream(values()).map(MesWmPackageStatusEnum::getStatus)
            .toArray(Integer[]::new);

    /**
     * 状态值
     */
    private final Integer status;
    /**
     * 状态名
     */
    private final String name;

    @Override
    public Integer[] array() {
        return ARRAYS;
    }

}
