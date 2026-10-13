package guanghe.gsite.module.system.service.member;

import cn.hutool.core.util.ClassUtil;
import cn.hutool.core.util.ReflectUtil;
import cn.hutool.extra.spring.SpringUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * Member Service 实现类
 *
 * guanghe-module-member 已裁剪，反射找不到 MemberUserApi 时统一返回 null，不影响管理端流程。
 *
 * @author 光何
 */
@Service
public class MemberServiceImpl implements MemberService {

    @Value("${guanghe.info.base-package}")
    private String basePackage;

    private volatile Object memberUserApi;

    @Override
    public String getMemberUserMobile(Long id) {
        Object user = getMemberUser(id);
        if (user == null) {
            return null;
        }
        return ReflectUtil.invoke(user, "getMobile");
    }

    @Override
    public String getMemberUserEmail(Long id) {
        Object user = getMemberUser(id);
        if (user == null) {
            return null;
        }
        return ReflectUtil.invoke(user, "getEmail");
    }

    private Object getMemberUser(Long id) {
        Object api = getMemberUserApi();
        if (id == null || api == null) {
            return null;
        }
        return ReflectUtil.invoke(api, "getUser", id);
    }

    private Object getMemberUserApi() {
        if (memberUserApi == null) {
            Class<?> clazz;
            try {
                clazz = ClassUtil.loadClass(String.format("%s.module.member.api.user.MemberUserApi", basePackage));
            } catch (Throwable ex) {
                // guanghe-module-member 已裁剪，无法加载时视为未启用
                return null;
            }
            if (clazz == null) {
                return null;
            }
            memberUserApi = SpringUtil.getBean(clazz);
        }
        return memberUserApi;
    }

}
