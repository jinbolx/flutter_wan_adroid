import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/config/storage_manager.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/ui/theme_helper.dart';

class ThemeModel with ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontIndex = 'kFontIndex';
  static const fontValueList = ['system', 'kuaile'];
  bool _userDarkMode;
  MaterialColor _themeColor;
  int _fontIndex;

  int get fontIndex => _fontIndex;

  ThemeModel() {
    _userDarkMode =
        StorageManager.sharedPreferences.getBool(kThemeUserDarkMode) ?? false;
    _themeColor = Colors.primaries[
            StorageManager.sharedPreferences.getInt(kThemeColorIndex)] ??
        5;
    _fontIndex = StorageManager.sharedPreferences.getInt(kFontIndex) ?? 0;
  }

  void switchTheme({bool userDarkMode, MaterialColor color}) {
    _userDarkMode = userDarkMode ?? _userDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    _saveTheme2Storage(userDarkMode, color);
  }

  void _saveTheme2Storage(bool userDarkMode, MaterialColor color) async {
    int index = Colors.primaries.indexOf(color);
    await Future.wait([
      StorageManager.sharedPreferences
          .setBool(kThemeUserDarkMode, userDarkMode),
      StorageManager.sharedPreferences.setInt(kThemeColorIndex, index)
    ]);
  }

  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
        userDarkMode: Random().nextBool(), color: Colors.primaries[colorIndex]);
  }

  void switchFont(int index) {
    _fontIndex = index;
    notifyListeners();
    _saveFontIndex(index);
  }

  ThemeData themeData({bool platformDarkMode = false}) {
    bool isDark = platformDarkMode || _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;
    var themeColor = _themeColor;
    var accentColor = isDark ? themeColor[700] : _themeColor;
    var themeData = ThemeData(
        brightness: brightness,
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        primarySwatch: themeColor,
        accentColor: accentColor,
        fontFamily: fontValueList[fontIndex]);
    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: accentColor,
      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: themeColor, brightness: brightness),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,
      textTheme: themeData.textTheme.copyWith(
        subhead: themeData.textTheme.subhead
            .copyWith(textBaseline: TextBaseline.alphabetic),
      ),
      textSelectionColor: accentColor.withAlpha(60),
      textSelectionHandleColor: accentColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor,
      ),
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );
    return themeData;
  }

  static _saveFontIndex(int index) async {
    await StorageManager.sharedPreferences.setInt(kFontIndex, index);
  }

  static String fontName(index, context) {
    switch (index) {
      case 1:
        return S.of(context).fontKuaiLe;
        break;
      default:
        return S.of(context).autoBySystem;
        break;
    }
  }
}
