part of 'product_bloc.dart';

@immutable
sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductInProgress extends ProductState {
  const ProductInProgress();
}

final class ProductFailure extends ProductState {
  const ProductFailure();
}

final class ProductSuccess extends ProductState {
  const ProductSuccess({required this.product});

  final Product product;

  @override
  List<Object?> get props => [product];
}
