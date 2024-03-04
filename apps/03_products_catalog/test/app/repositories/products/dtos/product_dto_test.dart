import 'package:flutter_test/flutter_test.dart';
import 'package:products_catalog/app/repositories/products/dtos/product_dto.dart';

import '../fixtures.dart' as fixtures;

void main() {
  group('ProductDto', () {
    test('should implement equality', () {
      const dtoA = fixtures.productDto;
      final dtoB = dtoA.copyWith();
      final dtoC = dtoA.copyWith(title: 'changed');

      expect(dtoA, equals(dtoB));
      expect(dtoA, isNot(equals(dtoC)));
    });

    test('should create an instance from a Map', () {
      final instance = ProductDto.fromMap(fixtures.productMap);
      expect(instance, equals(fixtures.productDto));
    });

    test('should create an instance from a Json string', () {
      final instance = ProductDto.fromJson(fixtures.productJson);
      expect(instance, equals(fixtures.productDto));
    });

    test('should create an instance from a Product', () {
      final instance = ProductDto.fromProduct(fixtures.product);
      expect(instance, equals(fixtures.productDto));
    });

    test('should convert to Product', () {
      expect(fixtures.productDto.toProduct(), fixtures.product);
    });
  });
}
