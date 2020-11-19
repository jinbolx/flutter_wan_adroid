import 'package:flutter/material.dart';

class ThemeHelper {
  static InputDecorationTheme inputDecorationTheme(ThemeData themeData) {
    var primaryColor = themeData.primaryColor;
    var dividerColor = themeData.dividerColor;
    var errorColor = themeData.errorColor;
    var disabledColor = themeData.disabledColor;
    var width = 0.5;

    return InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: errorColor),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: width, color: errorColor),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: width, color: primaryColor)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: width, color: dividerColor)),
        border: UnderlineInputBorder(
            borderSide: BorderSide(width: width, color: dividerColor)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: width, color: disabledColor)));
  }
}
