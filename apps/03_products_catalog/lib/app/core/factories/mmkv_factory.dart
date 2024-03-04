import 'package:mmkv/mmkv.dart';
import 'package:products_catalog/app/core/config/app_log_level.dart';
import 'package:products_catalog/app/utils/log_level_to_mmkv_level_adapter.dart';

sealed class MMKVFactory {
  static bool _initialized = false;

  static final MMKVLogLevel _mmkvLogLevel = AppLogLevel.level.toMMKVLogLevel();

  /// Ensure [MMKV] is initialized.
  ///
  /// One call is enough, more calls will be ignored.
  static Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    await MMKV.initialize(logLevel: _mmkvLogLevel);
  }

  /// May throw [UnsupportedError] if [init] was never called.
  static MMKV make({
    String container = '',
    String? cryptographyKey,
  }) {
    if (!_initialized) {
      throw UnsupportedError(
        '''Not initialized. Call `await MMKVFactory.init()` on the top level of the app.''',
      );
    }
    return MMKV(container, cryptKey: cryptographyKey);
  }
}
