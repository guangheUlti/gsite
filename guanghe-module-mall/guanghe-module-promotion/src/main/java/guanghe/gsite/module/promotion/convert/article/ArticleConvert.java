package guanghe.gsite.module.promotion.convert.article;

import guanghe.gsite.framework.common.pojo.PageResult;
import guanghe.gsite.module.promotion.controller.admin.article.vo.article.ArticleCreateReqVO;
import guanghe.gsite.module.promotion.controller.admin.article.vo.article.ArticleRespVO;
import guanghe.gsite.module.promotion.controller.admin.article.vo.article.ArticleUpdateReqVO;
import guanghe.gsite.module.promotion.controller.app.article.vo.article.AppArticleRespVO;
import guanghe.gsite.module.promotion.dal.dataobject.article.ArticleDO;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

/**
 * 文章管理 Convert
 *
 * @author 光何
 */
@Mapper
public interface ArticleConvert {

    ArticleConvert INSTANCE = Mappers.getMapper(ArticleConvert.class);

    ArticleDO convert(ArticleCreateReqVO bean);

    ArticleDO convert(ArticleUpdateReqVO bean);

    ArticleRespVO convert(ArticleDO bean);

    List<ArticleRespVO> convertList(List<ArticleDO> list);

    PageResult<ArticleRespVO> convertPage(PageResult<ArticleDO> page);

    AppArticleRespVO convert01(ArticleDO article);

    PageResult<AppArticleRespVO> convertPage02(PageResult<ArticleDO> articlePage);

    List<AppArticleRespVO> convertList03(List<ArticleDO> articleCategoryListByRecommendHotAndRecommendBanner);

}
