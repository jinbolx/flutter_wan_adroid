import 'dart:convert';
import 'dart:io';
import 'package:dio/native_imp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wan_android/utils/platform_utils.dart';

parJson(String json) => compute(jsonDecode, json);

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    (transformer as DefaultTransformer).jsonDecodeCallback = parJson;
    interceptors..add(HeadInterceptor());
    init();
  }

  void init();
}

class HeadInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    options.connectTimeout = 60 * 1000;
    options.receiveTimeout = 60 * 1000;
    options.sendTimeout = 60 * 1000;
    var appVersion = await PlatformUtils.getAppVersion();
    var version = Map()..addAll({'appVerison': appVersion});
    options.headers['version'] = version;
    options.headers['platform'] = Platform.operatingSystem;
    return options;
  }
}

abstract class BaseResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get success;

  BaseResponseData({this.code, this.message, this.data});

  @override
  String toString() {
    return 'BaseResponseData{code:$code,message:$message,data:$data}';
  }
}

class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData baseResponseData) {
    message = baseResponseData.message;
  }

  @override
  String toString() {
    return 'NotSuccessException{message:$message}';
  }
}

class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() {
    return 'UnAuthorizedException';
  }
}
