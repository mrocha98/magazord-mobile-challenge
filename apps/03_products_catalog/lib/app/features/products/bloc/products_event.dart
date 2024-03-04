part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

final class ProductsInitialized extends ProductsEvent {
  const ProductsInitialized();
}

final class ProductsSorted extends ProductsEvent {
  const ProductsSorted({required this.sortBy});

  final ProductsSortBy sortBy;

  @override
  List<Object?> get props => [sortBy];
}

final class ProductsCategorized extends ProductsEvent {
  const ProductsCategorized({required this.categories});

  final List<String> categories;

  @override
  List<Object?> get props => [categories];
}
