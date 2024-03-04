import 'package:flutter/material.dart' show ThemeMode;
import 'package:products_catalog/app/use_cases/use_case.dart';

abstract interface class GetThemeModeFromCacheUseCase
    implements UseCase<Future<ThemeMode?>, void> {}
