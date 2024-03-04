import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/core/ui/constants/page_padding.dart';
import 'package:products_catalog/app/features/products/details/bloc/product_bloc.dart';
import 'package:products_catalog/app/features/products/details/widgets/product_bottom_navigation_bar.dart';
import 'package:products_catalog/app/features/products/details/widgets/product_details.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    required this.productId,
    super.key,
  });

  final int productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    context.read<ProductBloc>().add(ProductInitialized(id: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final goRouter = GoRouter.of(context);

    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductFailure) {
          // TODO : hide loader
          // TODO : show error toast and push replacement to products route
        } else if (state is ProductInProgress) {
          // TODO : show loader
        } else {
          // TODO hide loader
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.onSecondary,
            foregroundColor: theme.colorScheme.secondary,
            leading:
                goRouter.canPop() ? BackButton(onPressed: goRouter.pop) : null,
            title: Text(
              'Product Details',
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                splashRadius: 12,
                tooltip: 'Add to favorites',
              ),
            ],
          ),
          body: Padding(
            padding: kPagePadding,
            child: state is ProductSuccess
                ? ProductDetails(product: state.product)
                : null,
          ),
          bottomNavigationBar: state is ProductSuccess
              ? ProductBottomNavigationBar(product: state.product)
              : null,
        );
      },
    );
  }
}
