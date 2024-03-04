import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/use_cases/use_case.dart';

abstract interface class GetProductUseCase
    implements UseCase<Future<Product?>, int> {}
