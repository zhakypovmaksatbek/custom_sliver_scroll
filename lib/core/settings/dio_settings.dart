// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:async";

import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

class DioSettings {
  DioSettings() {
    dio.interceptors.add(DioLoggingInterceptor());
  }

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://food.tatadev.pro/api/v1/',
      headers: {
        "Accept": "application/json",
      },
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<Response> post(String url, Object? data) async {
    final Response response = await dio.post(url, data: data);
    return response;
  }

  Future<Response> get(String url) async {
    final Response response = await dio.get(url);
    return response;
  }
}

class AuthDioSettings {
  AuthDioSettings() {
    dio.interceptors.add(DioLoggingInterceptor());
  }
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://food.tatadev.pro/api/v1/",
      contentType: "application/json",
      headers: {
        "Accept": "application/json",
        "Accept-Language": "ru",
      },
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
}

class DioLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('--- HTTP Request ---');
      print('URI: ${options.uri}');
      print('Method: ${options.method}');
      print('Query Parameters: ${options.queryParameters}');
      print('Headers: ${options.headers}');
      print('Request Data: ${options.data}');
      print('---------------------');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('--- HTTP Response ---');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('----------------------');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('--- HTTP Error ---');
      print('URI: ${err.requestOptions.uri}');
      print('Error: ${err.error}');
      print('Status Code: ${err.response?.statusCode}');
      print('Headers: ${err.response?.headers}');
      print('Response Data: ${err.response?.data}');
      print('---------------------');
    }
    super.onError(err, handler);
  }
}
