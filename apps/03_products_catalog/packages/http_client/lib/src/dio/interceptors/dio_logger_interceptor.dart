import 'package:dio/dio.dart';
import 'package:magazord_logger/logger.dart';

class DioLoggerInterceptor extends Interceptor {
  DioLoggerInterceptor(
    this._logger, {
    this.request = true,
    this.requestHeader = false,
    this.requestBody = false,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
  });

  DioLoggerInterceptor.verbose(this._logger)
      : request = true,
        requestHeader = true,
        requestBody = true,
        responseHeader = true,
        responseBody = true,
        error = true;

  DioLoggerInterceptor.silent(this._logger)
      : request = false,
        requestHeader = false,
        requestBody = false,
        responseHeader = false,
        responseBody = false,
        error = false;

  final Logger _logger;

  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  // ignore: comment_references
  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    _logger
      ..append('*** Request ***')
      ..append('uri: ${options.uri}');
    //options.headers;

    if (request) {
      _logger
        ..append('method: ${options.method}')
        ..append('responseType: ${options.responseType}')
        ..append('followRedirects: ${options.followRedirects}')
        ..append('persistentConnection: ${options.persistentConnection}')
        ..append('connectTimeout: ${options.connectTimeout}')
        ..append('sendTimeout: ${options.sendTimeout}')
        ..append('receiveTimeout: ${options.receiveTimeout}')
        ..append(
          'receiveDataWhenStatusError ${options.receiveDataWhenStatusError}',
        )
        ..append('extra: ${options.extra}');
    }
    if (requestHeader) {
      _logger.append('headers:');
      options.headers.forEach((key, v) => _logger.append(' $key: $v'));
    }
    if (requestBody) {
      _logger
        ..append('data:')
        ..append(options.data);
    }
    _logger
      ..append('')
      ..releaseAppended(LogLevel.info);

    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    _logger.append('*** Response ***');
    _appendResponse(response);
    _logger.releaseAppended(LogLevel.info);
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (error) {
      _logger
        ..append('*** DioException ***:')
        ..append('uri: ${err.requestOptions.uri}')
        ..append('$err');
      if (err.response != null) {
        _appendResponse(err.response!);
      }
      _logger
        ..append('')
        ..releaseAppended(LogLevel.error);
    }

    handler.next(err);
  }

  void _appendResponse(Response<dynamic> response) {
    _logger.append('uri: ${response.requestOptions.uri}');
    if (responseHeader) {
      _logger.append('statusCode: ${response.statusCode}');
      if (response.isRedirect == true) {
        _logger.append('redirect: ${response.realUri}');
      }

      _logger.append('headers:');
      response.headers
          .forEach((key, v) => _logger.append(' $key: ${v.join('\r\n\t')}'));
    }
    if (responseBody) {
      _logger.append('Response Text:');
      response.toString().split('\n').forEach(_logger.append);
    }
    _logger.append('');
  }
}
