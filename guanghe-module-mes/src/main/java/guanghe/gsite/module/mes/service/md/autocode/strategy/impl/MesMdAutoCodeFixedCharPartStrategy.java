package guanghe.gsite.module.mes.service.md.autocode.strategy.impl;

import cn.hutool.core.util.StrUtil;
import guanghe.gsite.module.mes.dal.dataobject.md.autocode.MesMdAutoCodePartDO;
import guanghe.gsite.module.mes.enums.md.autocode.MesMdAutoCodePartTypeEnum;
import guanghe.gsite.module.mes.service.md.autocode.strategy.MesMdAutoCodeContext;
import guanghe.gsite.module.mes.service.md.autocode.strategy.MesMdAutoCodePartStrategy;
import org.springframework.stereotype.Component;

/**
 * MES 编码规则 - 固定字符策略
 *
 * @author 光何
 */
@Component
public class MesMdAutoCodeFixedCharPartStrategy implements MesMdAutoCodePartStrategy {

    @Override
    public Integer getType() {
        return MesMdAutoCodePartTypeEnum.FIXED_CHAR.getType();
    }

    @Override
    public String generate(MesMdAutoCodePartDO part, MesMdAutoCodeContext context) {
        return StrUtil.emptyToDefault(part.getFixCharacter(), "");
    }

}
