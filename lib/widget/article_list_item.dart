import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/model/article.dart';
import 'package:flutter_wan_android/widget/article_tag.dart';
import 'package:flutter_wan_android/widget/image.dart';
import 'package:quiver/strings.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  final int index;
  final GestureTapCallback onTap;
  final bool top;
  final bool hideFavorite;

  ArticleItemWidget({@required this.article,
    this.index,
    this.onTap,
    this.top,
    this.hideFavorite});

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme
        .of(context)
        .scaffoldBackgroundColor;
    UniqueKey uniqueKey = UniqueKey();
    return Stack(
      children: [
        Material(
          color: top
              ? Theme
              .of(context)
              .accentColor
              .withAlpha(10)
              : backgroundColor,
          child: InkWell(
            onTap: onTap ?? () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: Divider.createBorderSide(context, width: 1))),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: WrapperImage(
                            imageType: ImageType.random,
                            url: article.author,
                            width: 20,
                            height: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          isNotBlank(article.author)
                              ? article.author
                              : isNotBlank(article.shareUser)
                              ? article.shareUser
                              : '',
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          article.niceDate,
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 5),
                    child: ArticleTitleWidget(article.title),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if(top)ArticleTag(text: S
                          .of(context)
                          .article_tag_top),
                      if(isNotBlank(article.superChapterName))
                        Padding(padding:EdgeInsets.only(bottom: 5),child: Text(article.superChapterName,style: Theme.of(context).textTheme.overline,),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ArticleTitleWidget extends StatelessWidget {
  final String title;

  ArticleTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Html(data: title);
  }
}

class ArticleFavoriteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
