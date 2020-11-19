import 'package:flutter/material.dart';

class ScaleAnimatedSwitcher extends StatelessWidget {
  final Widget child;

  ScaleAnimatedSwitcher({this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      child: child,
      duration: Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class EmptyAnimatedSwitcher extends StatelessWidget {
  final Widget child;
  final bool display;

  EmptyAnimatedSwitcher({this.child, this.display = true});

  @override
  Widget build(BuildContext context) {
    return ScaleAnimatedSwitcher(
      child: display ? child : SizedBox.shrink(),
    );
  }
}
