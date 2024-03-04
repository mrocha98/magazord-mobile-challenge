import 'package:flutter/material.dart' show ThemeMode;
import 'package:products_catalog/app/repositories/theme_mode/theme_mode_repository.dart';
import 'package:products_catalog/app/use_cases/save_theme_mode_in_cache/save_theme_mode_in_cache_use_case.dart';

class SaveThemeModeInCacheUseCaseImpl implements SaveThemeModeInCacheUseCase {
  const SaveThemeModeInCacheUseCaseImpl(this._themeModeRepository);

  final ThemeModeRepository _themeModeRepository;

  @override
  Future<void> call(ThemeMode themeMode) {
    return _themeModeRepository.saveInCache(themeMode);
  }
}
