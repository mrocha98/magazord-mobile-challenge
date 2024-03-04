import 'package:flutter_test/flutter_test.dart';
import 'package:magazord_common_packages_for_tests/common_packages_for_tests.dart';
import 'package:products_catalog/app/features/products/details/bloc/product_bloc.dart';
import 'package:products_catalog/app/models/product.dart';

import '../../../../../__fake__/__fake__.dart';
import '../../../../../__mocks__/__mocks__.dart';

void main() {
  group('ProductBloc', () {
    late ProductBloc sut;
    late MockLogger logger;
    late MockGetProductUseCase getProduct;
    final fakeProduct = ProductFakeFactory();
    late Product product;

    setUpAll(() {
      registerFallbackValue(StackTrace.empty);
    });

    setUp(() {
      logger = MockLogger();
      getProduct = MockGetProductUseCase();
      sut = ProductBloc(logger, getProduct);
      product = fakeProduct.make();
    });

    test('should have ProductInitial as initial state', () {
      expect(sut.state, isA<ProductInitial>());
    });

    blocTest<ProductBloc, ProductState>(
      'emits [ProductInProgress, ProductSuccess] '
      'when ProductInitialized is added '
      'and get a product with success',
      setUp: () {
        when(() => getProduct(1)).thenAnswer((_) async => product);
      },
      build: () => sut,
      act: (bloc) => bloc.add(const ProductInitialized(id: 1)),
      expect: () => [
        const ProductInProgress(),
        ProductSuccess(product: product),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductInProgress, ProductFailure] '
      'when ProductInitialized is added '
      'and get no product',
      setUp: () {
        when(() => getProduct(1)).thenAnswer((_) async => null);
      },
      build: () => sut,
      act: (bloc) => bloc.add(const ProductInitialized(id: 1)),
      expect: () => const [
        ProductInProgress(),
        ProductFailure(),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductInProgress, ProductFailure] '
      'when ProductInitialized is added '
      'and fails to get a product, '
      'also should log error',
      setUp: () {
        when(() => getProduct(1)).thenThrow(Exception());
        when(() => logger.error(any(), any(), any())).thenAnswer((_) async {});
      },
      build: () => sut,
      act: (bloc) => bloc.add(const ProductInitialized(id: 1)),
      expect: () => const [
        ProductInProgress(),
        ProductFailure(),
      ],
      verify: (_) {
        verify(
          () => logger.error(
            any(that: isNotEmpty),
            any(that: isNotNull),
            any(that: isNotNull),
          ),
        ).called(1);
      },
    );
  });
}
