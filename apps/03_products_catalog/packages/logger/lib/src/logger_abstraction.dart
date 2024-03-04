import 'dart:async';

import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_logger/src/log_level.dart';

abstract class Logger {
  LogLevel get level;

  set level(LogLevel value);

  FutureOr<void> debug(dynamic message);

  FutureOr<void> info(dynamic message);

  FutureOr<void> warning(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  FutureOr<void> error(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  FutureOr<void> fatal(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]);

  @protected
  bool canLog(LogLevel level) {
    return this.level >= level;
  }

  final _appended = StringBuffer();

  void append(dynamic message) {
    _appended.writeln(message);
  }

  FutureOr<void> releaseAppended([LogLevel level = LogLevel.debug]) {
    final message = _appended.toString();
    _appended.clear();
    final method = switch (level) {
      LogLevel.silent => (_) {},
      LogLevel.fatal => fatal,
      LogLevel.error => error,
      LogLevel.warning => warning,
      LogLevel.info => info,
      LogLevel.debug => debug,
    };
    return method(message);
  }
}
