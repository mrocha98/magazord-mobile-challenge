part of 'products_bloc.dart';

enum ProductsSortBy {
  none,
  lowerPrice,
  higherPrice,
}

@immutable
sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

final class ProductsInProgress extends ProductsState {
  const ProductsInProgress();
}

final class ProductsFailure extends ProductsState {
  const ProductsFailure();
}

final class ProductsSuccess extends ProductsState {
  const ProductsSuccess({
    this.products = const <Product>[],
    this.categories = const <String>[],
    this.sortBy = ProductsSortBy.none,
    this.selectedCategories = const <String>[],
  });

  final List<Product> products;

  final List<String> categories;

  final ProductsSortBy sortBy;

  final List<String> selectedCategories;

  @override
  List<Object?> get props => [
        products,
        categories,
        sortBy,
        selectedCategories,
      ];

  ProductsSuccess copyWith({
    List<Product>? products,
    List<String>? categories,
    ProductsSortBy? sortBy,
    List<String>? selectedCategories,
  }) {
    return ProductsSuccess(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      sortBy: sortBy ?? this.sortBy,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}
