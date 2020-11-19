import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActivityIndicator extends StatelessWidget {
  final double radius;
  final Brightness brightness;

  ActivityIndicator({this.radius, this.brightness});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          cupertinoOverrideTheme: CupertinoThemeData(brightness: brightness)),
      child: CupertinoActivityIndicator(radius: radius??10,),
    );

  }
}
