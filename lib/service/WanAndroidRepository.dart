import 'package:flutter_wan_android/config/net/urls.dart';
import 'package:flutter_wan_android/config/net/wan_android_api.dart';
import 'package:flutter_wan_android/model/article.dart';
import 'package:flutter_wan_android/model/banner.dart';

class WanAndroidRepository {
  static Future fetchBanners() async {
    var response = await http.get(banner_url);
    return (response.data as List)
        .map<Banner>((item) => Banner.fromJson(item))
        .toList();
  }

  static Future fetchTopArticles() async {
    var response = await http.get(top_article_url);
    return (response.data as List)
        .map<Article>((item) => Article.fromJson(item))
        .toList();
  }

  static Future fetchArticles(int pageNum, {int cid}) async {
    await Future.delayed(Duration(seconds: 1));
    var response = await http.get(articles_urls(pageNum),
        queryParameters: cid == null ? null : {'cid': cid});
    return (response.data['datas'] as List).map((item) => Article.fromJson(item)).toList();
  }
}
