import 'package:flutter_test/flutter_test.dart';
import 'package:products_catalog/app/features/products/details/bloc/product_bloc.dart';

import '../../../../../__fake__/__fake__.dart';

void main() {
  group('ProductState', () {
    final fakeProduct = ProductFakeFactory();

    group('ProductInitial', () {
      test('should instantiate', () {
        expect(const ProductInitial(), isA<ProductState>());
      });
    });

    group('ProductInProgress', () {
      test('should instantiate', () {
        expect(const ProductInProgress(), isA<ProductState>());
      });
    });

    group('ProductFailure', () {
      test('should instantiate', () {
        expect(const ProductFailure(), isA<ProductState>());
      });
    });

    group('ProductSuccess', () {
      test('should implement equality', () {
        final product = fakeProduct.make();
        final state = ProductSuccess(product: product);
        expect(state, isA<ProductState>());
        expect(
          state,
          isA<ProductSuccess>().having((s) => s.product, 'product', product),
        );
      });
    });
  });
}
