import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/config/resource_manager.dart';
import 'package:flutter_wan_android/generated/intl/messages_zh.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/provider/view_state.dart';

class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  ViewStateEmptyWidget(
      {Key key, this.message, this.image, this.buttonText, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: image ??
          Icon(
            IconFonts.pageEmpty,
            size: 100,
            color: Colors.grey,
          ),
      title: message??S.of(context).viewStateMessageEmpty,
      buttonText: buttonText,
      buttonTextData: S.of(context).viewStateButtonRefresh,
    );
  }
}

class ViewStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateWidget(
      {Key key,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle =
        Theme.of(context).textTheme.subhead.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(
        color: titleStyle.color.withOpacity(0.7), fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image ??
            Icon(
              IconFonts.pageError,
              size: 80,
              color: Colors.grey[700],
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title ?? S.of(context).viewStateMessageError,
                style: titleStyle,
              ),
              SizedBox(
                height: 20,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 150),
                child: SingleChildScrollView(
                  child: Text(
                    message ?? "",
                    style: messageStyle,
                  ),
                ),
              ),
              Center(
                child: ViewStateButton(
                  child: buttonText,
                  textData: buttonTextData,
                  onPressed: onPressed,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String title;
  final String message;
  final Widget image;
  final Widget buttonText;
  final String buttonTextData;
  final VoidCallback onPressed;

  ViewStateErrorWidget(
      {Key key,
      @required this.error,
      this.title,
      this.message,
      this.image,
      this.buttonText,
      this.buttonTextData,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    String defaultTextData = S.of(context).viewStateButtonRetry;
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = Transform.translate(
          offset: Offset(-50, 0),
          child: const Icon(
            IconFonts.pageNetworkError,
            size: 100,
            color: Colors.grey,
          ),
        );
        defaultTitle = S.of(context).viewStateMessageNetworkError;
        break;
      case ViewStateErrorType.defaultError:
        defaultImage = Icon(
          IconFonts.pageError,
          size: 100,
          color: Colors.grey,
        );
        defaultTitle = S.of(context).viewStateMessageError;
        break;
      case ViewStateErrorType.unauthorizedError:
        break;
    }
  }
}

class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String textData;

  ViewStateButton({@required this.onPressed, this.child, this.textData})
      : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ??
          Text(
            textData ?? S.of(context).viewStateButtonRetry,
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}

class ViewStateUnAuthWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  ViewStateUnAuthWidget(
      {Key key,
      this.message,
      this.image,
      this.buttonText,
      @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: onPressed,
      image: image ?? ViewStateUnAuthImage(),
      title: message ?? S.of(context).viewStateMessageUnAuth,
      buttonText: buttonText,
      buttonTextData: S.of(context).viewStateButtonLogin,
    );
  }
}

class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.warpAssets('login_logo.png'),
        width: 130,
        height: 130,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        // colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}
