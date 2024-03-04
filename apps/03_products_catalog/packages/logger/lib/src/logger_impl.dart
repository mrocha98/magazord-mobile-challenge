import 'dart:async';

import 'package:logger/logger.dart' as l;
import 'package:magazord_logger/src/log_level.dart';
import 'package:magazord_logger/src/logger_abstraction.dart';

class LoggerImpl extends Logger {
  LoggerImpl(this._logger, [this._level = LogLevel.debug]);

  final l.Logger _logger;

  LogLevel _level;

  @override
  LogLevel get level => _level;

  @override
  set level(LogLevel value) {
    _level = value;
  }

  @override
  FutureOr<void> debug(dynamic message) {
    if (canLog(LogLevel.debug)) {
      _logger.d(message);
    }
  }

  @override
  FutureOr<void> info(dynamic message) {
    if (canLog(LogLevel.info)) {
      _logger.i(message);
    }
  }

  @override
  FutureOr<void> warning(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (canLog(LogLevel.warning)) {
      _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  FutureOr<void> error(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (canLog(LogLevel.error)) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  FutureOr<void> fatal(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (canLog(LogLevel.fatal)) {
      _logger.f(message, error: error, stackTrace: stackTrace);
    }
  }
}
