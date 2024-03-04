import 'package:flutter/material.dart' show ThemeMode;
import 'package:products_catalog/app/repositories/theme_mode/theme_mode_repository.dart';
import 'package:products_catalog/app/use_cases/get_theme_mode_from_cache_use_case/get_theme_mode_from_cache_use_case.dart';

class GetThemeModeFromCacheUseCaseImpl implements GetThemeModeFromCacheUseCase {
  const GetThemeModeFromCacheUseCaseImpl(this._themeModeRepository);

  final ThemeModeRepository _themeModeRepository;

  @override
  Future<ThemeMode?> call(void _) {
    return _themeModeRepository.getFromCache();
  }
}
