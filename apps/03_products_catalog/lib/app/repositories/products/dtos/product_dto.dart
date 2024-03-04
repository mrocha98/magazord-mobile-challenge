import 'dart:convert';

import 'package:magazord_common_packages/common_packages.dart';
import 'package:products_catalog/app/models/product.dart';

@immutable
class ProductDto extends Equatable {
  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.ratingRate,
    required this.ratingCount,
  });

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    final rating = map['rating'] as Map<String, dynamic>;

    return ProductDto(
      id: (map['id'] as num).toInt(),
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      description: map['description'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      ratingRate: (rating['rate'] as num).toDouble(),
      ratingCount: (rating['count'] as num).toInt(),
    );
  }

  factory ProductDto.fromProduct(Product product) {
    return ProductDto(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      ratingRate: product.rateAverage,
      ratingCount: product.rateCount,
    );
  }

  factory ProductDto.fromJson(String source) =>
      ProductDto.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;

  final String title;

  final double price;

  final String description;

  final String category;

  final String image;

  final double ratingRate;

  final int ratingCount;

  @override
  List<Object> get props {
    return [
      id,
      title,
      price,
      description,
      category,
      image,
      ratingRate,
      ratingCount,
    ];
  }

  ProductDto copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    double? ratingRate,
    int? ratingCount,
  }) {
    return ProductDto(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      ratingRate: ratingRate ?? this.ratingRate,
      ratingCount: ratingCount ?? this.ratingCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {
        'rate': ratingRate,
        'count': ratingCount,
      },
    };
  }

  String toJson() => json.encode(toMap());

  Product toProduct() {
    return Product(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      image: image,
      rateAverage: ratingRate,
      rateCount: ratingCount,
    );
  }
}
