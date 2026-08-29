package guanghe.gsite.module.member.convert.signin;

import guanghe.gsite.module.member.controller.admin.signin.vo.config.MemberSignInConfigCreateReqVO;
import guanghe.gsite.module.member.controller.admin.signin.vo.config.MemberSignInConfigRespVO;
import guanghe.gsite.module.member.controller.admin.signin.vo.config.MemberSignInConfigUpdateReqVO;
import guanghe.gsite.module.member.controller.app.signin.vo.config.AppMemberSignInConfigRespVO;
import guanghe.gsite.module.member.dal.dataobject.signin.MemberSignInConfigDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 签到规则 Convert
 *
 * @author 光何
 */
@Mapper
public interface MemberSignInConfigConvert {

    MemberSignInConfigConvert INSTANCE = Mappers.getMapper(MemberSignInConfigConvert.class);

    MemberSignInConfigDO convert(MemberSignInConfigCreateReqVO bean);

    MemberSignInConfigDO convert(MemberSignInConfigUpdateReqVO bean);

    MemberSignInConfigRespVO convert(MemberSignInConfigDO bean);

    List<MemberSignInConfigRespVO> convertList(List<MemberSignInConfigDO> list);

    List<AppMemberSignInConfigRespVO> convertList02(List<MemberSignInConfigDO> list);

}
