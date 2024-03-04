import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/app/models/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    required this.product,
    required this.onTap,
    super.key,
  });

  final Product product;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: product.image,
        height: 64,
        width: 64,
        fit: BoxFit.fill,
      ),
      title: Text(
        product.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      onTap: onTap,
    );
  }
}
