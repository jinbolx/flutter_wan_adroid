import 'package:flutter/cupertino.dart';

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;

  NoAnimRouteBuilder(this.page)
      : super(
    opaque: false,
    pageBuilder: (context, animation, secAnimation) => page,
    transitionDuration: Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secAnimation, child) =>
    child,
  );
}

class FadeRouteBuilder extends PageRouteBuilder {
  final Widget page;

  FadeRouteBuilder(this.page)
      : super(
      pageBuilder: (context, animation, secAnimation) => page,
      transitionDuration: Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secAnimation, child) {
        return FadeTransition(
          opacity: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
              parent: animation, curve: Curves.fastOutSlowIn)),
          child: child,
        );
      });
}

class SlideTopRouteBuilder extends PageRouteBuilder {
  final Widget page;


}

