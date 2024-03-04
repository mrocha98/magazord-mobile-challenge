import 'package:flutter_test/flutter_test.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';
import 'package:magazord_http_client/http_client.dart';
import 'package:products_catalog/app/repositories/products/products_repository_impl.dart';

import '../../../__mocks__/__mocks__.dart';
import 'fixtures.dart' as fixtures;

void main() {
  group('ProductsRepositoryImpl', () {
    late ProductsRepositoryImpl sut;
    late MockHttpClient http;
    late MockKeyValueStorage kv;
    final faker = Faker.instance;

    setUp(() {
      http = MockHttpClient();
      kv = MockKeyValueStorage();
      sut = ProductsRepositoryImpl(http, kv);
    });

    group('.getProductsFromApi', () {
      test('should parse response then return a list of Products', () async {
        when(() => http.get<List>('/products')).thenAnswer(
          (_) async => const HttpClientResponse(data: [fixtures.productMap]),
        );

        final result = await sut.getProductsFromApi();

        expect(result, [fixtures.product]);
      });
    });

    group('.saveProductsCache', () {
      test('should store list in cache with correct key', () async {
        when(() => kv.set<List<String>>(any(), any<List<String>>()))
            .thenAnswer((_) async {});

        final products = List.generate(3, (_) => fixtures.product);
        final productsJsonList = List.generate(3, (_) => fixtures.productJson);
        await sut.saveProductsInCache(products);

        verify(
          () => kv.set<List<String>>(
            ProductsRepositoryImpl.productsCacheKey,
            productsJsonList,
          ),
        ).called(1);
      });
    });

    group('.getProductFromApi', () {
      test('when response data is String should return null', () async {
        final id = faker.datatype.number();
        when(() => http.get<dynamic>('/products/$id')).thenAnswer(
          (_) async => const HttpClientResponse<String>(data: ''),
        );

        final result = await sut.getProductFromApi(id);

        expect(result, isNull);
      });

      test('when response data is Map should return Product', () async {
        final id = faker.datatype.number();
        when(() => http.get<dynamic>('/products/$id')).thenAnswer(
          (_) async => const HttpClientResponse<Map>(data: fixtures.productMap),
        );

        final result = await sut.getProductFromApi(id);

        expect(result, fixtures.product);
      });
    });

    group('.getProductsCategoriesFromApi', () {
      test('should parse response then return a list of Strings', () async {
        final categories = List.generate(5, (_) => faker.commerce.department());
        when(() => http.get<List>('/products/categories'))
            .thenAnswer((_) async => HttpClientResponse(data: categories));

        final result = await sut.getProductsCategoriesFromApi();

        expect(result, categories);
      });
    });

    group('.saveProductsCategoriesInCache', () {
      test('should store list in cache with correct key', () async {
        when(() => kv.set<List<String>>(any(), any<List<String>>()))
            .thenAnswer((_) async {});

        final categories = List.generate(3, (_) => faker.commerce.department());
        await sut.saveProductsCategoriesInCache(categories);

        verify(
          () => kv.set(ProductsRepositoryImpl.categoriesCacheKey, categories),
        ).called(1);
      });
    });
  });
}
