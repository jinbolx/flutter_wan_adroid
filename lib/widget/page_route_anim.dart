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

  SlideTopRouteBuilder(this.page)
      : super(
      pageBuilder: (context, animation, secAnimation) => page,
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
              begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
              .animate(CurvedAnimation(
              parent: animation, curve: Curves.fastOutSlowIn)),
          child: child,
        );
      });
}

class SizeRoute extends PageRouteBuilder {
  final Widget page;

  SizeRoute(this.page)
      :super(pageBuilder: (context, animation, secAnimation) => page,
      transitionDuration: Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secAnimation, child) {
        return ScaleTransition(child: child,
          scale: Tween(begin: 0.2, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),);
      });
}