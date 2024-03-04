import 'package:flutter/material.dart' show ThemeMode;
import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_key_value_storage/key_value_storage.dart';
import 'package:products_catalog/app/repositories/theme_mode/theme_mode_repository.dart';

class ThemeModeRepositoryImpl implements ThemeModeRepository {
  const ThemeModeRepositoryImpl(this._kv);

  final KeyValueStorage _kv;

  @visibleForTesting
  static const storageKey = 'theme-mode';

  @override
  Future<ThemeMode?> getFromCache() async {
    final value = await _kv.get<String>(storageKey);
    if (value == null) return null;
    return ThemeMode.values.byName(value);
  }

  @override
  Future<void> saveInCache(ThemeMode themeMode) async {
    await _kv.set(storageKey, themeMode.name);
  }
}
