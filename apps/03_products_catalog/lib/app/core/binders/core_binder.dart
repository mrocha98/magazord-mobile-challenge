import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_http_client/http_client.dart';
import 'package:magazord_key_value_storage/key_value_storage.dart';
import 'package:magazord_logger/logger.dart';
import 'package:nested/nested.dart';
import 'package:products_catalog/app/core/binders/binder.dart';
import 'package:products_catalog/app/core/factories/dio_factory.dart';
import 'package:products_catalog/app/core/factories/factories.dart';
import 'package:products_catalog/app/core/ui/theme/bloc/theme_mode_bloc.dart';
import 'package:products_catalog/app/repositories/theme_mode/theme_mode_repository.dart';
import 'package:products_catalog/app/repositories/theme_mode/theme_mode_repository_impl.dart';
import 'package:products_catalog/app/use_cases/get_theme_mode_from_cache_use_case/get_theme_mode_from_cache_use_case.dart';
import 'package:products_catalog/app/use_cases/get_theme_mode_from_cache_use_case/get_theme_mode_from_cache_use_case_impl.dart';
import 'package:products_catalog/app/use_cases/save_theme_mode_in_cache/save_theme_mode_in_cache_use_case.dart';
import 'package:products_catalog/app/use_cases/save_theme_mode_in_cache/save_theme_mode_in_cache_use_case_impl.dart';

final class CoreBinder implements Binder {
  const CoreBinder({
    required Logger logger,
  }) : _logger = logger;

  final Logger _logger;

  @override
  List<SingleChildWidget> get binds {
    return [
      RepositoryProvider<Logger>.value(
        value: _logger,
      ),
      RepositoryProvider<HttpClient>(
        create: (context) => HttpClientDioImpl(
          DioFactory.make(
            baseOptions: BaseOptions(
              baseUrl: 'https://fakestoreapi.com/',
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
            ),
            dioLoggerInterceptor: DioLoggerInterceptor(context.read<Logger>()),
          ),
        ),
      ),
      RepositoryProvider<KeyValueStorage>(
        create: (context) => KeyValueStorageMMKVImpl(
          MMKVFactory.make(container: 'MAGAZORD'),
        ),
      ),
      RepositoryProvider<ThemeModeRepository>(
        create: (context) => ThemeModeRepositoryImpl(
          context.read<KeyValueStorage>(),
        ),
      ),
      RepositoryProvider<GetThemeModeFromCacheUseCase>(
        create: (context) => GetThemeModeFromCacheUseCaseImpl(
          context.read<ThemeModeRepository>(),
        ),
      ),
      RepositoryProvider<SaveThemeModeInCacheUseCase>(
        create: (context) => SaveThemeModeInCacheUseCaseImpl(
          context.read<ThemeModeRepository>(),
        ),
      ),
      BlocProvider<ThemeModeBloc>(
        create: (context) => ThemeModeBloc(
          context.read<GetThemeModeFromCacheUseCase>(),
          context.read<SaveThemeModeInCacheUseCase>(),
        ),
      ),
    ];
  }
}
