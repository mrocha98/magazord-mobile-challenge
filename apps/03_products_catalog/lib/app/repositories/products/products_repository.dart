import 'package:products_catalog/app/models/product.dart';

abstract interface class ProductsRepository {
  Future<List<Product>> getProductsFromApi();

  Future<List<Product>> getProductsFromCache();

  Future<void> saveProductsInCache(List<Product> products);

  Future<Product?> getProductFromApi(int id);

  Future<List<String>> getProductsCategoriesFromApi();

  Future<List<String>> getProductsCategoriesFromCache();

  Future<void> saveProductsCategoriesInCache(List<String> categories);
}
