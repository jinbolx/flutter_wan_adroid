import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_wan_android/config/net/api.dart';
import 'package:flutter_wan_android/config/storage_manager.dart';
final http=Http();
class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://www.wanandroid.com/';
    interceptors
      ..add(ApiInterceptor())
      ..add(
          CookieManager(PersistCookieJar(dir: StorageManager.directory.path)));
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
   onRequest(RequestOptions options) {
    debugPrint('---api-request--->url-->${options.baseUrl}${options.path}' +
        '\ncontentType: ${options.contentType}' +
        '\nqueryParameters: ${options.queryParameters}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    JsonEncoder encoder =  JsonEncoder();
    String prettyPrint = encoder.convert(response.data);
    debugPrint('response: $prettyPrint');
    ResponseData responseData = ResponseData.formJson(response.data);
    if(responseData.success){
      response.data=responseData.data;
      return http.resolve(response);
    }else{
      if(responseData.code==-1001){
        throw const UnAuthorizedException();
      }else{
        throw NotSuccessException.fromRespData(responseData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  @override
  bool get success => 0 == code;

  ResponseData.formJson(Map<String, dynamic> map) {
    code = map['errorCode'];
    message = map['errorMsg'];
    data = map['data'];
  }
}
