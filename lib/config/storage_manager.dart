import 'dart:io';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class StorageManager {
  static SharedPreferences sharedPreferences;
  static Directory directory;
  static LocalStorage localStorage;

  static init() async {
    directory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage("localStorage");
    await localStorage.ready;
  }
}
