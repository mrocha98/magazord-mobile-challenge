import 'package:dio/dio.dart';
import 'package:magazord_common_packages/common_packages.dart';

/// Dio [Options] does not implements equality, which can be a pain to mock.
///
/// This class has the sole intention to extends [Options] and implement
/// equality using [Equatable].
class OptionsWithEquality extends Options with EquatableMixin {
  OptionsWithEquality({
    super.method,
    super.sendTimeout,
    super.receiveTimeout,
    super.extra,
    super.headers,
    super.preserveHeaderCase,
    super.responseType,
    super.contentType,
    super.validateStatus,
    super.receiveDataWhenStatusError,
    super.followRedirects,
    super.maxRedirects,
    super.persistentConnection,
    super.requestEncoder,
    super.responseDecoder,
    super.listFormat,
  });

  @override
  List<Object?> get props => [
        method,
        sendTimeout,
        receiveTimeout,
        extra,
        headers,
        preserveHeaderCase,
        responseType,
        contentType,
        validateStatus,
        receiveDataWhenStatusError,
        followRedirects,
        maxRedirects,
        persistentConnection,
        requestEncoder,
        responseDecoder,
        listFormat,
      ];
}
