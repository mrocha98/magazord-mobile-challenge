import 'package:dio/dio.dart';
import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_http_client/src/dio/dio_exception_to_http_client_exception_adapter.dart';
import 'package:magazord_http_client/src/dio/dio_response_to_http_client_response_adapter.dart';
import 'package:magazord_http_client/src/dio/options_with_equality.dart';
import 'package:magazord_http_client/src/http_client.dart';
import 'package:magazord_http_client/src/http_client_response.dart';

@immutable
class HttpClientDioImpl implements HttpClient {
  const HttpClientDioImpl(this._dio);

  final Dio _dio;

  @override
  Future<HttpClientResponse<T>> get<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        options: OptionsWithEquality(headers: headers),
        queryParameters: queryParameters,
      );
      return response.toHttpClientResponse();
    } on DioException catch (ex) {
      throw ex.toHttpClientException();
    }
  }
}
