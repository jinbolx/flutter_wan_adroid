import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android/model/page_entity.dart';
import 'package:flutter_wan_android/provider/view_state_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  @override
  Future<List<T>> refresh({bool init = false}) async {
    try {
      pageEntity.resetPage();
      var data = await loadData(page: pageEntity.currentPage);
      if (data.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageEntity.pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        setIdle();
      }
      return data;
    } catch (e, s) {
      if (init) list.clear();
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<List<T>> loadMore() async {
    try {
      pageEntity.nextPage();
      var data = await loadData(page: pageEntity.currentPage);
      if (data.isEmpty) {
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageEntity.pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      pageEntity.prePage();
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }
}
