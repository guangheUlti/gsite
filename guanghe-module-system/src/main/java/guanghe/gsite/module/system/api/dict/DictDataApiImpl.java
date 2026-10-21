package guanghe.gsite.module.system.api.dict;

import guanghe.gsite.framework.common.util.object.BeanUtils;
import guanghe.gsite.framework.common.biz.system.dict.dto.DictDataRespDTO;
import guanghe.gsite.module.system.dal.dataobject.dict.DictDataDO;
import guanghe.gsite.module.system.service.dict.DictDataService;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;
import java.util.Collection;
import java.util.List;

/**
 * 字典数据 API 实现类
 *
 * @author 光何
 */
@Service
public class DictDataApiImpl implements DictDataApi {

    @Resource
    private DictDataService dictDataService;

    @Override
    public void validateDictDataList(String dictType, Collection<String> values) {
        dictDataService.validateDictDataList(dictType, values);
    }

    @Override
    public List<DictDataRespDTO> getDictDataList(String dictType) {
        List<DictDataDO> list = dictDataService.getDictDataListByDictType(dictType);
        return BeanUtils.toBean(list, DictDataRespDTO.class);
    }

}
