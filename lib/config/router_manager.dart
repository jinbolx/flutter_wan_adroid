import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/page/Splash.dart';
import 'package:flutter_wan_android/page/tab/tab_navigator.dart';
import 'package:flutter_wan_android/widget/page_route_anim.dart';

class RouteName {
  static const String splash = 'splash';
  static const String tab = '/';
  static const String homeSecondFloor = 'homeSecondFloor';
  static const String login = 'login';
  static const String register = 'register';
  static const String articleDetail = 'articleDetail';
  static const String favouriteList = 'favouriteList';
  static const String setting = 'setting';
  static const String coinRecordList = 'coinRecordList';
  static const String coinRankingList = 'coinRankingList';
}
class Routers{
 static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.splash:
        return NoAnimRouteBuilder(Splash());
      case RouteName.tab:
        return NoAnimRouteBuilder(TabNavigator());
    }
 }
}
