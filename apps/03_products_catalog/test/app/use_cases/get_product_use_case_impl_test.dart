import 'package:flutter_test/flutter_test.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';
import 'package:products_catalog/app/use_cases/get_product/get_product_use_case_impl.dart';

import '../../__fake__/__fake__.dart';
import '../../__mocks__/__mocks__.dart';

void main() {
  group('GetProductUseCaseImpl', () {
    late GetProductUseCaseImpl sut;
    late MockProductsRepository productsRepository;
    final faker = Faker.instance;
    final fakeProduct = ProductFakeFactory();

    setUp(() {
      productsRepository = MockProductsRepository();
      sut = GetProductUseCaseImpl(productsRepository);
    });

    group('.call', () {
      test('should get product from api', () async {
        final id = faker.datatype.number();
        final product = fakeProduct.make();
        when(() => productsRepository.getProductFromApi(id))
            .thenAnswer((_) async => product);

        final result = await sut(id);

        expect(result, product);
      });
    });
  });
}
