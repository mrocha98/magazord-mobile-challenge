import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_http_client/http_client.dart';
import 'package:magazord_key_value_storage/key_value_storage.dart';
import 'package:magazord_logger/logger.dart';
import 'package:nested/nested.dart';
import 'package:products_catalog/app/core/binders/binder.dart';
import 'package:products_catalog/app/features/products/details/bloc/product_bloc.dart';
import 'package:products_catalog/app/repositories/products/products_repository.dart';
import 'package:products_catalog/app/repositories/products/products_repository_impl.dart';
import 'package:products_catalog/app/use_cases/get_product/get_product_use_case.dart';
import 'package:products_catalog/app/use_cases/get_product/get_product_use_case_impl.dart';

class ProductDetailsBinder implements Binder {
  @override
  List<SingleChildWidget> get binds {
    return [
      RepositoryProvider<ProductsRepository>(
        create: (context) => ProductsRepositoryImpl(
          context.read<HttpClient>(),
          context.read<KeyValueStorage>(),
        ),
      ),
      RepositoryProvider<GetProductUseCase>(
        create: (context) => GetProductUseCaseImpl(
          context.read<ProductsRepository>(),
        ),
      ),
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc(
          context.read<Logger>(),
          context.read<GetProductUseCase>(),
        ),
      ),
    ];
  }
}
