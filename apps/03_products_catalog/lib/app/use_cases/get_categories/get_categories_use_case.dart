import 'package:products_catalog/app/use_cases/use_case.dart';

abstract interface class GetCategoriesUseCase
    implements UseCase<Future<List<String>>, void> {}
