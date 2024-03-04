import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:products_catalog/app/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    required this.product,
    super.key,
  });

  final Product product;

  String get _whatsappShareText {
    final text = StringBuffer()
      ..write('Product ${product.title} is costing ')
      ..write('\$${product.price.toStringAsFixed(2)} ')
      ..write('on Products Catalog app!');
    return text.toString();
  }

  Future<void> _shareOnWhatsapp() async {
    final uri = Uri.https(
      'api.whatsapp.com',
      '/send',
      {'text': _whatsappShareText},
    );
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (_, __) => const SizedBox.expand(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      label: Text(product.category),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(height: 2),
                    Semantics(
                      header: true,
                      child: Text(
                        product.title,
                        style: theme.textTheme.headlineSmall,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Tooltip(
                    message:
                        '''Rate average: ${product.rateAverage}; Total rates: ${product.rateCount}''',
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          '${product.rateAverage.toStringAsFixed(1)} '
                          '(${product.rateCount})',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/whatsapp.svg',
                      // ignore: deprecated_member_use
                      color: Colors.green,
                      width: 20,
                      height: 20,
                    ),
                    tooltip: 'Share on WhatsApp',
                    splashRadius: 12,
                    onPressed: _shareOnWhatsapp,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            product.description,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
