import 'package:magazord_common_packages/common_packages.dart';

@immutable
class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.image,
    required this.rateAverage,
    required this.rateCount,
  });

  final int id;

  final String title;

  final String description;

  final String category;

  final double price;

  final String image;

  final double rateAverage;

  final int rateCount;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        image,
        rateAverage,
        rateCount,
      ];

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    String? image,
    double? rateAverage,
    int? rateCount,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
      rateAverage: rateAverage ?? this.rateAverage,
      rateCount: rateCount ?? this.rateCount,
    );
  }
}
