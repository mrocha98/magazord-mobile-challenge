import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_http_client/http_client.dart';
import 'package:magazord_key_value_storage/key_value_storage.dart';
import 'package:magazord_logger/logger.dart';
import 'package:nested/nested.dart';
import 'package:products_catalog/app/core/binders/binder.dart';
import 'package:products_catalog/app/features/products/bloc/products_bloc.dart';
import 'package:products_catalog/app/repositories/products/products_repository.dart';
import 'package:products_catalog/app/repositories/products/products_repository_impl.dart';
import 'package:products_catalog/app/use_cases/get_categories/get_categories_use_case.dart';
import 'package:products_catalog/app/use_cases/get_categories/get_categories_use_case_impl.dart';
import 'package:products_catalog/app/use_cases/get_products/get_products_use_case.dart';
import 'package:products_catalog/app/use_cases/get_products/get_products_use_case_impl.dart';

class ProductsBinder implements Binder {
  @override
  List<SingleChildWidget> get binds {
    return [
      RepositoryProvider<ProductsRepository>(
        create: (context) => ProductsRepositoryImpl(
          context.read<HttpClient>(),
          context.read<KeyValueStorage>(),
        ),
      ),
      RepositoryProvider<GetProductsUseCase>(
        create: (context) => GetProductsUseCaseImpl(
          context.read<ProductsRepository>(),
        ),
      ),
      RepositoryProvider<GetCategoriesUseCase>(
        create: (context) => GetCategoriesUseCaseImpl(
          context.read<ProductsRepository>(),
        ),
      ),
      BlocProvider<ProductsBloc>(
        create: (context) => ProductsBloc(
          context.read<Logger>(),
          context.read<GetProductsUseCase>(),
          context.read<GetCategoriesUseCase>(),
        ),
      ),
    ];
  }
}
