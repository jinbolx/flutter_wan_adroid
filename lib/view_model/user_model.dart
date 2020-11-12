import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android/config/storage_manager.dart';
import 'package:flutter_wan_android/provider/view_state.dart';
import 'package:flutter_wan_android/provider/view_state_model.dart';
import 'package:flutter_wan_android/view_model/favorite_model.dart';
import 'package:flutter_wan_android/model/user.dart';

class UserModel with ChangeNotifier {
  static const String kUser = 'kUser';
  final GlobalFavoriteStateModel globalFavoriteStateModel;

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel({@required this.globalFavoriteStateModel}) {
    var userMap = StorageManager.localStorage.getItem(kUser);
    _user = userMap != null ? User.fromJsonMap(userMap) : null;
  }
  saveUser(User user){
    _user=user;
    notifyListeners();
  }
}
