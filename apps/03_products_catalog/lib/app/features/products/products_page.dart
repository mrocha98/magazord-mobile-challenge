import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/core/ui/helpers/helpers.dart';
import 'package:products_catalog/app/features/products/bloc/products_bloc.dart';
import 'package:products_catalog/app/features/products/details/product_details_router.dart';
import 'package:products_catalog/app/features/products/widgets/product_grid_tile.dart';
import 'package:products_catalog/app/features/products/widgets/product_list_tile.dart';
import 'package:products_catalog/app/models/product.dart';

enum _ProductsViewMode {
  grid,
  list,
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with AfterLayoutMixin, LoaderMixin, ToastMixin {
  final _viewMode = ValueNotifier<_ProductsViewMode>(_ProductsViewMode.grid);

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    context.read<ProductsBloc>().add(const ProductsInitialized());
  }

  @override
  void dispose() {
    _viewMode.dispose();
    super.dispose();
  }

  void _onProductTap(Product product) {
    context.pushNamed(
      ProductDetailsRouter.name,
      pathParameters: {'id': product.id.toString()},
    );
  }

  String _getSortByLabel(ProductsSortBy sortBy) {
    return switch (sortBy) {
      ProductsSortBy.none => 'default',
      ProductsSortBy.lowerPrice => 'lower price',
      ProductsSortBy.higherPrice => 'higher price',
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) async {
        if (state is ProductsFailure) {
          hideLoader();
          showError('Failed to get products and categories...');
        } else if (state is ProductsInProgress) {
          await showLoader();
        } else {
          hideLoader();
        }
      },
      builder: (context, state) {
        if (state is! ProductsSuccess) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories: (${state.selectedCategories.length})'),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return FilterChip(
                    label: Text(category),
                    selected: state.selectedCategories.contains(category),
                    onSelected: (selected) {
                      final categories = List.of(state.selectedCategories);
                      if (selected) {
                        categories.add(category);
                      } else {
                        categories.remove(category);
                      }
                      context.read<ProductsBloc>().add(
                            ProductsCategorized(
                              categories: categories,
                            ),
                          );
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(width: 8),
              ),
            ),
            Row(
              children: [
                ValueListenableBuilder<_ProductsViewMode>(
                  valueListenable: _viewMode,
                  builder: (context, viewMode, _) {
                    return Row(
                      children: [
                        ChoiceChip.elevated(
                          label: const Icon(Icons.grid_view),
                          selected: viewMode == _ProductsViewMode.grid,
                          onSelected: (selected) {
                            _viewMode.value = selected
                                ? _ProductsViewMode.grid
                                : _ProductsViewMode.list;
                          },
                          showCheckmark: false,
                        ),
                        ChoiceChip.elevated(
                          label: const Icon(Icons.list),
                          selected: viewMode == _ProductsViewMode.list,
                          onSelected: (selected) {
                            _viewMode.value = selected
                                ? _ProductsViewMode.list
                                : _ProductsViewMode.grid;
                          },
                          showCheckmark: false,
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.filter_alt),
                    DropdownButton<ProductsSortBy>(
                      value: state.sortBy,
                      isDense: true,
                      items: ProductsSortBy.values
                          .map(
                            (sortBy) => DropdownMenuItem(
                              value: sortBy,
                              child: Text(_getSortByLabel(sortBy)),
                            ),
                          )
                          .toList(growable: false),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<ProductsBloc>()
                              .add(ProductsSorted(sortBy: value));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ValueListenableBuilder<_ProductsViewMode>(
                valueListenable: _viewMode,
                builder: (context, viewMode, _) {
                  if (viewMode == _ProductsViewMode.grid) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.sizeOf(context).width / 2.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductGridTile(
                          key: Key('product-card--${product.id}'),
                          product: product,
                          onTap: () => _onProductTap(product),
                        );
                      },
                    );
                  }
                  return ListView.separated(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductListTile(
                        key: Key('product-list-title--${product.id}'),
                        product: product,
                        onTap: () => _onProductTap(product),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
