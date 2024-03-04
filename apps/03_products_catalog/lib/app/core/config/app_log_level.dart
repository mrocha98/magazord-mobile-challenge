import 'package:flutter/foundation.dart';
import 'package:magazord_logger/logger.dart';

sealed class AppLogLevel {
  static LogLevel? _level;

  static LogLevel get level {
    return _level ??= _defineLevel();
  }

  static LogLevel _defineLevel() {
    return kReleaseMode ? LogLevel.error : LogLevel.debug;
  }
}
