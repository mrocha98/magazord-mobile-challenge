import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magazord_common_packages/common_packages.dart';
import 'package:magazord_logger/logger.dart';
import 'package:products_catalog/app/models/product.dart';
import 'package:products_catalog/app/use_cases/get_categories/get_categories_use_case.dart';
import 'package:products_catalog/app/use_cases/get_products/get_products_use_case.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(
    this._logger,
    this._getProducts,
    this._getCategories,
  ) : super(const ProductsInitial()) {
    on<ProductsInitialized>(_onProductsInitialized);
    on<ProductsCategorized>(_onProductsCategorized);
    on<ProductsSorted>(_onProductsSorted);
  }

  final Logger _logger;

  final GetProductsUseCase _getProducts;

  final GetCategoriesUseCase _getCategories;

  @visibleForTesting
  late final List<Product> productsBackup;

  Future<void> _onProductsInitialized(
    ProductsInitialized event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsInProgress());
    try {
      final [
        products as List<Product>,
        categories as List<String>,
      ] = await Future.wait([_getProducts(null), _getCategories(null)]);
      productsBackup = List.of(products, growable: false);
      emit(
        ProductsSuccess(
          products: products,
          categories: categories,
        ),
      );
    } catch (ex, st) {
      _logger.error('Failure on event $event', ex, st);
      emit(const ProductsFailure());
    }
  }

  void _onProductsCategorized(
    ProductsCategorized event,
    Emitter<ProductsState> emit,
  ) {
    assert(
      this.state is ProductsSuccess,
      'Cannot categorize products when state is not ProductsSuccess',
    );

    final state = this.state as ProductsSuccess;
    var productsFiltered = List.of(productsBackup, growable: false);
    if (event.categories.isNotEmpty) {
      productsFiltered = productsFiltered
          .where((product) => event.categories.contains(product.category))
          .toList(growable: false);
    }
    _sortProducts(productsFiltered, state.sortBy);
    emit(
      state.copyWith(
        products: productsFiltered,
        selectedCategories: event.categories,
      ),
    );
  }

  void _onProductsSorted(
    ProductsSorted event,
    Emitter<ProductsState> emit,
  ) {
    assert(
      this.state is ProductsSuccess,
      'Cannot sort products when state is not ProductsSuccess',
    );

    final state = this.state as ProductsSuccess;
    final listToSort = List.of(state.products, growable: false);
    _sortProducts(listToSort, event.sortBy);

    emit(
      state.copyWith(
        products: listToSort,
        sortBy: event.sortBy,
      ),
    );
  }

  void _sortProducts(List<Product> products, ProductsSortBy sortBy) {
    products.sort(
      switch (sortBy) {
        ProductsSortBy.higherPrice => _sortByHigherPriceCompare,
        ProductsSortBy.lowerPrice => _sortByLowerPriceCompare,
        ProductsSortBy.none => _sortById,
      },
    );
  }

  int _sortByHigherPriceCompare(Product a, Product b) {
    return b.price.compareTo(a.price);
  }

  int _sortByLowerPriceCompare(Product a, Product b) {
    return a.price.compareTo(b.price);
  }

  int _sortById(Product a, Product b) {
    return a.id.compareTo(b.id);
  }
}
