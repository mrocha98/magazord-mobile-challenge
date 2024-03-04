import 'dart:convert';

import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/repositories/products/dtos/product_dto.dart';

const productMap = <String, dynamic>{
  'id': 42,
  'title': 'French Fries',
  'price': 5.99,
  'description': 'Fried potato',
  'category': 'fast food',
  'image': 'https://url.com',
  'rating': {
    'rate': 4.2,
    'count': 20,
  },
};

final productJson = json.encode(productMap);

const product = Product(
  id: 42,
  title: 'French Fries',
  description: 'Fried potato',
  category: 'fast food',
  price: 5.99,
  image: 'https://url.com',
  rateAverage: 4.2,
  rateCount: 20,
);

const productDto = ProductDto(
  id: 42,
  title: 'French Fries',
  price: 5.99,
  description: 'Fried potato',
  category: 'fast food',
  image: 'https://url.com',
  ratingRate: 4.2,
  ratingCount: 20,
);
