import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android/model/article.dart';

class GlobalFavoriteStateModel with ChangeNotifier {
  static final Map<int, bool> _map = Map();

  static refresh(List<Article> list) {
    list.forEach((element) {
      if (_map.containsKey(element.id)) {
        _map[element.id] = element.collect;
      }
    });
  }

  addFavorite(int id) {
    _map[id] = true;
    notifyListeners();
  }

  removeFavorite(int id) {
    _map[id] = false;
  }

  replaceAll(List<int> ids) {
    _map.clear();
    ids.forEach((element) {
      _map[element] = true;
    });
    notifyListeners();
  }
  contains(int id)=>_map.containsKey(id);
  operator [](int id){
    return _map[id];
  }
}
