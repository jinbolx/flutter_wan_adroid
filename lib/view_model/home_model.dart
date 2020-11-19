import 'package:flutter_wan_android/model/article.dart';
import 'package:flutter_wan_android/model/banner.dart';
import 'package:flutter_wan_android/model/page_entity.dart';
import 'package:flutter_wan_android/provider/view_state_refresh_list_model.dart';
import 'package:flutter_wan_android/service/WanAndroidRepository.dart';
import 'package:flutter_wan_android/view_model/favorite_model.dart';

class HomeModel extends ViewStateRefreshListModel<Article> {
  List<Banner> _banners;
  List<Article> _topArticles;

  List<Banner> get banners => _banners;
  List<Article> get topArticles=>_topArticles;

  @override
  Future<List<Article>> loadData({int page}) async {
    List<Future> futures = [];
    if (pageEntity.isFirstPage()) {
      futures.add(WanAndroidRepository.fetchBanners());
      futures.add(WanAndroidRepository.fetchTopArticles());
    }
    futures.add(WanAndroidRepository.fetchArticles(page));
    var result = await Future.wait(futures);
    if (pageEntity.isFirstPage()) {
      _banners = result[0];
      _topArticles=result[1];
      return result[2];
    }else{
      return result[0];
    }
  }

  @override
  onCompleted(List<Article> data) {
   GlobalFavoriteStateModel.refresh(data);
  }

}
