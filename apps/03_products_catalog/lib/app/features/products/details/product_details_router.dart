import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/features/products/details/product_details_binder.dart';
import 'package:products_catalog/app/features/products/details/product_details_page.dart';

sealed class ProductDetailsRouter {
  static const _path = '/products/:id';

  static const name = 'product-details';

  static final route = GoRoute(
    path: _path,
    name: name,
    pageBuilder: (context, state) {
      final idPathParameter = state.pathParameters['id']!;
      final productId = int.parse(idPathParameter);

      return NoTransitionPage(
        child: MultiBlocProvider(
          providers: ProductDetailsBinder().binds,
          child: ProductDetailsPage(productId: productId),
        ),
      );
    },
  );
}
