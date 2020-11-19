import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/widget/activity_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final strings = RefreshLocalizations.of(context)?.currentLocalization ??
        EnRefreshString();
    return ClassicHeader(
      canTwoLevelText: S.of(context).refreshTwoLevel,
      textStyle: TextStyle(color: Colors.white),
      outerBuilder: (child) => Container(),
      twoLevelView: Container(),
      height: 70 + MediaQuery.of(context).padding.top / 3,
      refreshingIcon: ActivityIndicator(
        brightness: Brightness.dark,
      ),
      releaseText: strings.canRefreshText,
    );
  }
}
class RefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter();
  }
}

