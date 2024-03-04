import 'package:dio/dio.dart';
import 'package:magazord_http_client/http_client.dart';

sealed class DioFactory {
  static Dio make({
    required DioLoggerInterceptor dioLoggerInterceptor,
    BaseOptions? baseOptions,
  }) {
    return Dio(baseOptions)
      ..interceptors.addAll([
        dioLoggerInterceptor, // must be the last one
      ]);
  }
}
