part of 'product_bloc.dart';

@immutable
sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class ProductInitialized extends ProductEvent {
  const ProductInitialized({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
