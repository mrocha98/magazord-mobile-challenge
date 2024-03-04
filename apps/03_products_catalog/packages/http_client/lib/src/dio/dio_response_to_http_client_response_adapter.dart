import 'package:dio/dio.dart';
import 'package:magazord_http_client/src/http_client_response.dart';

extension DioResponseToHttpClientResponseAdapter<T> on Response<T> {
  HttpClientResponse<T> toHttpClientResponse() {
    return HttpClientResponse<T>(
      data: data as T,
      statusCode: statusCode,
    );
  }
}
