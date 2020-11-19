import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_wan_android/config/provider_manager.dart';
import 'package:flutter_wan_android/config/router_manager.dart';
import 'package:flutter_wan_android/config/storage_manager.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/view_model/local_model.dart';
import 'package:flutter_wan_android/view_model/theme_model.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
      providers: independentServices,
      child: Consumer2<ThemeModel, LocalModel>(
        builder: (context, themeModel, localModel, child) {
          return RefreshConfiguration(
            hideFooterWhenNotFull: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeModel.themeData(),
              darkTheme: themeModel.themeData(platformDarkMode: true),
              locale: localModel.locale,
              localizationsDelegates: [
                S.delegate,
                RefreshLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
              onGenerateRoute: Routers.generateRoute,
              initialRoute: RouteName.splash,
            ),
          );
        },
      ),
    ));
  }
}
