import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_http_client/http_client.dart';
import 'package:magazord_key_value_storage/key_value_storage.dart';
import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/repositories/products/dtos/product_dto.dart';
import 'package:products_catalog/app/repositories/products/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl(this._http, this._kv);

  final HttpClient _http;

  final KeyValueStorage _kv;

  @visibleForTesting
  static const productsCacheKey = 'PRODUCTS';

  @visibleForTesting
  static const categoriesCacheKey = 'CATEGORIES';

  @override
  Future<List<Product>> getProductsFromApi() async {
    final response = await _http.get<List>('/products');
    return List<Map<String, dynamic>>.from(response.data, growable: false)
        .map((m) => ProductDto.fromMap(m).toProduct())
        .toList(growable: false);
  }

  @override
  Future<List<Product>> getProductsFromCache() async {
    final productsStringList = await _kv.get<List<String>>(productsCacheKey);
    if (productsStringList == null) return const <Product>[];
    return productsStringList
        .map((jsonStr) => ProductDto.fromJson(jsonStr).toProduct())
        .toList(growable: false);
  }

  @override
  Future<void> saveProductsInCache(List<Product> products) async {
    final listToSave = products
        .map((p) => ProductDto.fromProduct(p).toJson())
        .toList(growable: false);
    await _kv.set<List<String>>(productsCacheKey, listToSave);
  }

  @override
  Future<Product?> getProductFromApi(int id) async {
    // when there is no product with giving id the api still responds with 200
    // but the response body is just an empty string
    final response = await _http.get<dynamic>('/products/$id');
    if (response.data is String) {
      return null;
    }

    final map = Map<String, dynamic>.from(response.data as Map);
    return ProductDto.fromMap(map).toProduct();
  }

  @override
  Future<List<String>> getProductsCategoriesFromApi() async {
    final response = await _http.get<List>('/products/categories');
    return List<String>.from(response.data, growable: false);
  }

  @override
  Future<List<String>> getProductsCategoriesFromCache() async {
    final categoriesInCache = await _kv.get<List<String>>(categoriesCacheKey);
    return categoriesInCache ?? const <String>[];
  }

  @override
  Future<void> saveProductsCategoriesInCache(List<String> categories) async {
    await _kv.set<List<String>>(categoriesCacheKey, categories);
  }
}
