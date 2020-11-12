import 'package:flutter/cupertino.dart';
import 'package:flutter_wan_android/config/storage_manager.dart';
import 'package:flutter_wan_android/generated/l10n.dart';

class LocalModel with ChangeNotifier {
  static const localValueList = ['', 'zh-CN', 'en'];
  static const kLocalIndex = 'kLocalIndex';
  int _localIndex;

  int get localIndex => _localIndex;

  Locale get locale {
    if (_localIndex > 0) {
      var value = localValueList[_localIndex].split('-');
      return Locale(value[0], value.length == 2 ? value[1] : '');
    }
    return Locale('');
  }

  switchLocale(int index) {
    _localIndex = index;
    notifyListeners();
    StorageManager.sharedPreferences.setInt(kLocalIndex, index);
  }

  LocalModel() {
    _localIndex = StorageManager.sharedPreferences.getInt(kLocalIndex);
  }

  static String localeName(index, context) {
    switch (index) {
      case 0:
        return S.of(context).autoBySystem;
      case 1:
        return '中文';
      case 2:
        return 'English';
      default:
        return '';
    }
  }
}
