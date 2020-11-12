import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan_android/generated/l10n.dart';
import 'package:flutter_wan_android/provider/view_state.dart';
import 'package:oktoast/oktoast.dart';

class ViewStateModel with ChangeNotifier {
  bool _disposed = false;
  ViewState _viewState;
  static const String _TAG = 'ViewStateModel';

  ViewStateModel({ViewState viewState})
      : _viewState = viewState ?? ViewState.idle {
    debugPrint('$_TAG----constructor---->$runtimeType');
  }

  ViewState get viewState => _viewState;
  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  set viewState(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;
    notifyListeners();
  }

  bool get isIdle => viewState == ViewState.idle;

  bool get isBusy => viewState == ViewState.busy;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  setIdle() {
    viewState = ViewState.idle;
  }

  setBusy() {
    viewState = ViewState.busy;
  }

  setEmpty() {
    viewState = ViewState.empty;
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('$_TAG dispose-->$runtimeType');
    super.dispose();
  }

  @override
  void notifyListeners() {
    debugPrint('$_TAG notifyListeners-->$runtimeType');
    if (!_disposed) {
      debugPrint('$_TAG notifyListeners---success-->$runtimeType');
      super.notifyListeners();
    }
  }

  void setError(e, stack, {String message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    if (e is DioError) {
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.SEND_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.RESPONSE) {
        message=e.error;
      }else if(e.type==DioErrorType.CANCEL){
        message=e.error;
      }else{

      }
    }
  }

  showErrorMessage(context, {String message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError.isNetworkTimeout) {
        message ??= S.of(context).viewStateMessageNetworkError;
      } else {
        message ??= viewStateError.message;
      }
      Future.microtask(() {
        showToast(message, context: context);
      });
    }
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}
