import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/config/resource_manager.dart';
import 'package:flutter_wan_android/config/router_manager.dart';
import 'package:flutter_wan_android/generated/l10n.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State with TickerProviderStateMixin {
  AnimationController _logoController;
  Animation _animation;
  AnimationController _countdownController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _logoController, curve: Curves.easeInOutBack));
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _logoController.forward();
      }
    });
    _logoController.forward();
    _countdownController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _countdownController.forward();
  }

  @override
  void dispose() {

    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              ImageHelper.warpAssets(
                  Theme.of(context).brightness == Brightness.light
                      ? 'splash_bg.png'
                      : 'splash_bg_dark.png'),
              fit: BoxFit.fill,
            ),
            AnimatedFlutterLogo(
              animation: _animation,
            ),
            Align(
              alignment: Alignment(0.0, 0.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedAndroidLogo(
                    animation: _animation,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SafeArea(
                child: InkWell(
                  onTap: () {
                    nextPage(context);
                  },
                  child: Container(
                    width: 90,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withAlpha(80),
                    ),
                    // padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    child: AnimatedCountdown(
                      context: context,
                      animation: StepTween(begin: 3, end: 0)
                          .animate(_countdownController),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedFlutterLogo extends AnimatedWidget {
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return AnimatedAlign(
      duration: Duration(milliseconds: 0),
      alignment: Alignment(0, 0.2 + animation.value * 0.25),
      // curve: Curves.bounceOut,
      curve: Curves.decelerate,
      child: Image.asset(
        ImageHelper.warpAssets('splash_flutter.png'),
        width: 200,
        height: 120,
      ),
    );
  }

  AnimatedFlutterLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
}

class AnimatedAndroidLogo extends AnimatedWidget {
  AnimatedAndroidLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          ImageHelper.warpAssets('splash_fun.png'),
          width: 140 * animation.value,
          height: 80 * animation.value,
        ),
        Image.asset(
          ImageHelper.warpAssets('splash_android.png'),
          width: 200 * (1 - animation.value),
          height: 80 * (1 - animation.value),
        )
      ],
    );
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({Key key, this.animation, BuildContext context})
      : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Text(
      value == 0 ? '' : '$value | ' + S.of(context).splashSkip,
      style: TextStyle(color: Colors.white),
    );
  }
}

void nextPage(context) {
  Navigator.of(context).pushReplacementNamed(RouteName.tab);
}
