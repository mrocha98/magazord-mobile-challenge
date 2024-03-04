import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_logger/logger.dart';
import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/use_cases/get_product/get_product_use_case.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this._logger, this._getProduct) : super(const ProductInitial()) {
    on<ProductInitialized>(_onProductInitialized);
  }

  final Logger _logger;

  final GetProductUseCase _getProduct;

  Future<void> _onProductInitialized(
    ProductInitialized event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductInProgress());
    try {
      final product = await _getProduct(event.id);
      final newState = product == null
          ? const ProductFailure()
          : ProductSuccess(product: product);
      emit(newState);
    } catch (ex, st) {
      _logger.error('Failure on event $event', ex, st);
      emit(const ProductFailure());
    }
  }
}
