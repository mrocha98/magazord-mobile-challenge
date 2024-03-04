import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products_catalog/app/models/product.dart';

class ProductBottomNavigationBar extends StatelessWidget {
  const ProductBottomNavigationBar({
    required this.product,
    required this.onAddToCartTap,
    super.key,
  });

  final Product product;

  final VoidCallback? onAddToCartTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 16).copyWith(
        bottom: Platform.isIOS ? 0 : null,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 2,
            color: Colors.black.withOpacity(.3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: 'Price: ',
                children: [
                  TextSpan(
                    text: '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onAddToCartTap,
              child: const Row(
                children: [
                  Icon(Icons.shopping_bag),
                  SizedBox(width: 4),
                  Text('Add do Cart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
