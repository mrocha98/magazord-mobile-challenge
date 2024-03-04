import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/core/ui/widgets/widgets.dart';
import 'package:products_catalog/app/features/configs/configs_router.dart';
import 'package:products_catalog/app/features/products/details/product_details_router.dart';
import 'package:products_catalog/app/features/products/products_router.dart';

sealed class AppRouter {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: ProductsRouter.path,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          final title = switch (state.fullPath) {
            ProductsRouter.path => 'Products',
            ConfigsRouter.path => 'Configs',
            _ => '',
          };
          return DefaultScaffold(
            title: title,
            body: child,
          );
        },
        routes: <RouteBase>[
          ProductsRouter.route,
          ConfigsRouter.route,
        ],
      ),
      ProductDetailsRouter.route,
    ],
  );
}
