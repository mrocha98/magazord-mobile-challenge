import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/use_cases/use_case.dart';

abstract interface class GetProductsUseCase
    implements UseCase<Future<List<Product>>, void> {}
