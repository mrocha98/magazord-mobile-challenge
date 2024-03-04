import 'package:magazord_http_client/src/http_client_response.dart';

abstract interface class HttpClient {
  Future<HttpClientResponse<T>> get<T>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
