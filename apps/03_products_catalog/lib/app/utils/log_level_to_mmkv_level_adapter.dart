import 'package:magazord_logger/logger.dart';
import 'package:mmkv/mmkv.dart';

extension LogLevelToMMKVLevelAdapter on LogLevel {
  MMKVLogLevel toMMKVLogLevel() {
    return switch (this) {
      LogLevel.silent => MMKVLogLevel.None,
      LogLevel.debug => MMKVLogLevel.Debug,
      LogLevel.warning => MMKVLogLevel.Warning,
      LogLevel.info => MMKVLogLevel.Info,
      LogLevel.fatal || LogLevel.error => MMKVLogLevel.Error,
    };
  }
}
