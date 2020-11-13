import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/page/tab/home_page.dart';
import 'package:flutter_wan_android/page/tab/project_page.dart';
import 'package:flutter_wan_android/page/tab/structure_page.dart';
import 'package:flutter_wan_android/page/tab/user_page.dart';
import 'package:flutter_wan_android/page/tab/wechat_account_page.dart';

final pages = <Widget>[
  HomePage(),
  ProjectPage(),
  WeChatAccountPage(),
  StructurePage(),
  UserPage()
];

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();

  TabNavigator({Key key}) : super(key: key);
}

class _TabNavigatorState extends State<TabNavigator> {
  final _pageController = PageController();
  int _selectIndex = 0;
  DateTime _lastPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressed == null ||
              DateTime.now().difference(_lastPressed) > Duration(seconds: 1)) {
            _lastPressed = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
          physics: BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: S.of(context).tabHome),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              label: S.of(context).tabProject),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_work), label: S.of(context).wechatAccount),
          BottomNavigationBarItem(icon: Icon(Icons.call_split),
          label: S.of(context).tabStructure),
          BottomNavigationBarItem(icon: Icon(Icons.insert_emoticon)
          ,label: S.of(context).tabUser)
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
