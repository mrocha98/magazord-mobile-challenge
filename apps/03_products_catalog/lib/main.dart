import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart' as logger_pkg;
import 'package:magazord_logger/logger.dart';
import 'package:products_catalog/app/app_widget.dart';
import 'package:products_catalog/app/core/binders/core_binder.dart';
import 'package:products_catalog/app/core/bloc_observers/default_bloc_observer.dart';
import 'package:products_catalog/app/core/config/app_log_level.dart';
import 'package:products_catalog/app/core/factories/factories.dart';

Future<void> main() async {
  await MMKVFactory.init();

  final Logger logger = LoggerImpl(
    logger_pkg.Logger(
      printer: logger_pkg.PrettyPrinter(printTime: true),
    ),
    AppLogLevel.level,
  );

  Bloc.observer = DefaultBlocObserver(logger);

  FlutterError.onError = (details) {
    final FlutterErrorDetails(:context, :stack) = details;
    final error = details.exceptionAsString();
    logger.fatal(context, error, stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.fatal(
      'An unexpected error occurred in PlatformDispatcher',
      error,
      stack,
    );
    return true;
  };

  runApp(
    MultiBlocProvider(
      providers: CoreBinder(logger: logger).binds,
      child: const AppWidget(),
    ),
  );
}
