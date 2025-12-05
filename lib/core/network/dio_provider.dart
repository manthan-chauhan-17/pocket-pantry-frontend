import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pocket_pantry_frontend/core/error/app_exceptions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dio = getDio();

Dio getDio() {
  BaseOptions options = BaseOptions(
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
    contentType: 'application/json',
    responseType: ResponseType.json,
  );

  final dio = Dio(options);

  dio.interceptors.add(
    PrettyDioLogger(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint(
          'REQUEST[${options.method}] => PATH:${options.baseUrl}${options.path}',
        );
        debugPrint('REQUEST[${options.method}] => DATA: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        );
        debugPrint(
          'RESPONSE[${response.statusCode}] => DATA: ${response.data}',
        );
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        debugPrint(
          'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}',
        );
        debugPrint(
          'ERROR[${e.response?.statusCode}] => DATA: ${e.response?.data}',
        );

        final appException = _handleDioError(e);

        return handler.reject(
          DioException(
            requestOptions: e.requestOptions,
            error: appException,
            response: e.response,
            type: e.type,
          ),
        );
      },
    ),
  );

  return dio;
}

AppException _handleDioError(DioException error) {
  String errorMessage;

  switch (error.type) {
    case DioExceptionType.cancel:
      errorMessage = 'Request to the server was cancelled.';
      break;
    case DioExceptionType.connectionTimeout:
      errorMessage =
          'Connection timed out. Please check your internet connection.';
      break;
    case DioExceptionType.receiveTimeout:
      errorMessage =
          'Receiving timeout occurred in connection with API server.';
      break;
    case DioExceptionType.sendTimeout:
      errorMessage = 'Send timeout in connection with API server.';
      break;
    case DioExceptionType.badResponse:
      errorMessage = _handleStatusCode(error.response?.statusCode);
      break;
    case DioExceptionType.connectionError:
      errorMessage = 'Connection error. Please check your internet connection.';
      break;
    case DioExceptionType.unknown:
    default:
      errorMessage = 'Something went wrong. Please try again later.';
      break;
  }

  return AppException(
    message: errorMessage,
    statusCode: error.response?.statusCode,
  );
}

String _handleStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request';
    case 401:
      return 'Unauthorized'; // User is not Authenticated
    case 403:
      return 'Forbidden'; // Authenticated User is not allowed for this request
    case 404:
      return 'Not found';
    case 500:
      return 'Internal server error';
    case 503:
      return 'Service unavailable';
    default:
      return 'Oops something went wrong';
  }
}
