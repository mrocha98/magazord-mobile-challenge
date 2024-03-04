import 'package:products_catalog/app/repositories/products/products_repository.dart';
import 'package:products_catalog/app/use_cases/get_categories/get_categories_use_case.dart';

class GetCategoriesUseCaseImpl implements GetCategoriesUseCase {
  const GetCategoriesUseCaseImpl(this._productsRepository);

  final ProductsRepository _productsRepository;

  @override
  Future<List<String>> call(void _) async {
    final categoriesInCache =
        await _productsRepository.getProductsCategoriesFromCache();
    if (categoriesInCache.isNotEmpty) {
      return categoriesInCache;
    }

    final categoriesFromApi =
        await _productsRepository.getProductsCategoriesFromApi();
    await _productsRepository.saveProductsCategoriesInCache(categoriesFromApi);
    return categoriesFromApi;
  }
}
