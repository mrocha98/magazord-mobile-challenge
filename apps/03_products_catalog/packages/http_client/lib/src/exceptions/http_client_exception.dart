import 'package:flutter/foundation.dart' hide HttpClientResponse;
import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_http_client/src/http_client_response.dart';

@immutable
class HttpClientException extends Equatable implements Exception {
  const HttpClientException({
    required this.error,
    required this.response,
    this.message,
    this.statusCode,
  });

  final int? statusCode;

  final dynamic error;

  final HttpClientResponse<dynamic> response;

  final String? message;

  @override
  List<Object?> get props => [
        statusCode,
        error,
        response,
        message,
      ];

  HttpClientException copyWith({
    ValueGetter<int?>? statusCode,
    dynamic error,
    HttpClientResponse<dynamic>? response,
  }) {
    return HttpClientException(
      statusCode: statusCode != null ? statusCode() : this.statusCode,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }
}
