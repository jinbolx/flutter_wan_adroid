import 'package:flutter_wan_android/view_model/favorite_model.dart';
import 'package:flutter_wan_android/view_model/local_model.dart';
import 'package:flutter_wan_android/view_model/theme_model.dart';
import 'package:flutter_wan_android/view_model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices
];
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocalModel>(
    create: (context) => LocalModel(),
  ),
  ChangeNotifierProvider<GlobalFavoriteStateModel>(
      create: (context) => GlobalFavoriteStateModel())
];

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProxyProvider<GlobalFavoriteStateModel, UserModel>(
      create: null,
      update: (context, globalModel, userModel) {
        return userModel;
      })
];
