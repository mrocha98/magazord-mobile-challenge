import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/app/models/product.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    required this.product,
    required this.onTap,
    super.key,
  });

  final Product product;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).primaryColor,
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (_, __) => const SizedBox.expand(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
