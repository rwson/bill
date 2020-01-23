import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';

import 'package:bill/api.dart';

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('userToken');
  return token;
}

class HttpResponse<T> {

  bool success;
  String message;
  T data;

  HttpResponse({
    this.success,
    this.message,
    this.data
 });

 factory HttpResponse.formJson(json) {
   return HttpResponse(
     success: json['success'],
     message: json['message'],
     data: json['data']
   );
 }
}

class HttpUtil {
  static Dio dio;

  static const String API_PREFIX = Api.base;
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static const String UNKNOWN_ERROR = '发生未知错误';
  static const String CONNECT_ERROR = '服务器好像开小差了, 等会再试吧~';

  static Future<Map<String, dynamic>> request(String url, [data, method]) async {
    data = data ?? {};
    method = method ?? 'GET';

    final String token = await getToken();

    Dio dio = createInstance();

    final Options options = new Options(
      method: method,
      headers: {
        'authorization': 'Bearer $token'
      }
    );

    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    var result;

    try {
      Response response = await dio.request(url, data: data, options: options);
      result = response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        result = e.response.data;
      } else {
        BotToast.showText(text: CONNECT_ERROR);
      }
    }

    return result;
  }

  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = new BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      dio = new Dio(options);
    }

    return dio;
  }

  static clear() {
    dio = null;
  }
}
