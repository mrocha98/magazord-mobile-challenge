import 'package:dio/dio.dart';
import 'package:magazord_http_client/src/exceptions/exceptions.dart';
import 'package:magazord_http_client/src/http_client_response.dart';

extension DioExceptionToHttpClientExceptionAdapter on DioException {
  HttpClientException toHttpClientException() {
    return HttpClientException(
      message: message,
      statusCode: response?.statusCode,
      error: this,
      response: HttpClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
      ),
    );
  }
}
