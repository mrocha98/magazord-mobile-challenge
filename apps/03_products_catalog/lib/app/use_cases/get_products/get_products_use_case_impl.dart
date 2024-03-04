import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/repositories/products/products_repository.dart';
import 'package:products_catalog/app/use_cases/get_products/get_products_use_case.dart';

class GetProductsUseCaseImpl implements GetProductsUseCase {
  const GetProductsUseCaseImpl(this._productsRepository);

  final ProductsRepository _productsRepository;

  @override
  Future<List<Product>> call(void _) async {
    final productsInCache = await _productsRepository.getProductsFromCache();
    if (productsInCache.isNotEmpty) {
      return productsInCache;
    }

    final productsFromApi = await _productsRepository.getProductsFromApi();
    await _productsRepository.saveProductsInCache(productsFromApi);
    return productsFromApi;
  }
}
