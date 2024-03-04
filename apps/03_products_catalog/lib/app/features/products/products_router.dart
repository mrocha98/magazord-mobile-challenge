import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/features/products/products_binder.dart';
import 'package:products_catalog/app/features/products/products_page.dart';

sealed class ProductsRouter {
  static const path = '/products';

  static final route = GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: MultiBlocProvider(
          providers: ProductsBinder().binds,
          child: const ProductsPage(),
        ),
      );
    },
  );
}
