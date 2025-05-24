import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'dart:developer' as dev;
import 'package:pocket_pantry_frontend/services/api_service/retorfit/rest_client.dart';

// Change the base URL to your server's IP address
final restClient =
    RestClient(baseUrl: "http://192.168.0.101:3000/api/v1/", dio);

final dio = getDio();

Dio getDio() {
  BaseOptions options = BaseOptions(
    receiveDataWhenStatusError: true,
    contentType: "application/json",
    sendTimeout: const Duration(seconds: 30),
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  Dio dio = Dio(options);
  dio.interceptors.add(LogInterceptor());
  dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
    dev.log('Api Request Body: ${request.data}');
    return handler.next(request);
  }, onResponse: (Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      debugPrint('status code 200');
    }
    // dev.log('Api Response: ${response.data}');
    // dev.log('Api Url: ${response.realUri}');
    return handler.next(response);
  }, onError: (DioException e, handler) {
    final response = e.response;
    dev.log(
        'Api Error --> statusCode: ${response?.statusCode} --> ${response?.statusMessage} : Error ==> ${e.toString()}');
    return handler.next(e);
  }));
  return dio;
}
