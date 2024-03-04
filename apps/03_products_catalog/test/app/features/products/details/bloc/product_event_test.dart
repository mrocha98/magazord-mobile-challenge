import 'package:flutter_test/flutter_test.dart';
import 'package:products_catalog/app/features/products/details/bloc/product_bloc.dart';

void main() {
  group('ProductEvent', () {
    group('ProductInitialized', () {
      test('should implement equality', () {
        const event = ProductInitialized(id: 1);
        expect(event, isA<ProductEvent>());
        expect(event, isA<ProductInitialized>().having((e) => e.id, 'id', 1));
      });
    });
  });
}
