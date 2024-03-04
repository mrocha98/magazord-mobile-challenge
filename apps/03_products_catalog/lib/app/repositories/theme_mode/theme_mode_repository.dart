import 'package:flutter/material.dart' show ThemeMode;

abstract interface class ThemeModeRepository {
  Future<ThemeMode?> getFromCache();

  Future<void> saveInCache(ThemeMode themeMode);
}
