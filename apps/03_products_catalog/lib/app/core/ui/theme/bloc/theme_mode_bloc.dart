import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_common_packages/common_packages.dart';
import 'package:products_catalog/app/use_cases/get_theme_mode_from_cache_use_case/get_theme_mode_from_cache_use_case.dart';
import 'package:products_catalog/app/use_cases/save_theme_mode_in_cache/save_theme_mode_in_cache_use_case.dart';

part 'theme_mode_event.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeMode> {
  ThemeModeBloc(
    this._getThemeModeFromCache,
    this._saveThemeModeInCache,
  ) : super(ThemeMode.system) {
    on<ThemeModeInitialized>(_onThemeModeInitialized);
    on<ThemeModeChanged>(_onThemeModeChanged);
  }

  final GetThemeModeFromCacheUseCase _getThemeModeFromCache;

  final SaveThemeModeInCacheUseCase _saveThemeModeInCache;

  Future<void> _onThemeModeInitialized(
    ThemeModeInitialized event,
    Emitter<ThemeMode> emit,
  ) async {
    final themeModeInCache = await _getThemeModeFromCache(null);
    if (themeModeInCache != null) {
      emit(themeModeInCache);
    }
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeMode> emit,
  ) async {
    await _saveThemeModeInCache(event.themeMode);
    emit(event.themeMode);
  }
}
