import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/repositories/products/products_repository.dart';
import 'package:products_catalog/app/use_cases/get_product/get_product_use_case.dart';

class GetProductUseCaseImpl implements GetProductUseCase {
  const GetProductUseCaseImpl(this._productsRepository);

  final ProductsRepository _productsRepository;

  @override
  Future<Product?> call(int productId) {
    return _productsRepository.getProductFromApi(productId);
  }
}
