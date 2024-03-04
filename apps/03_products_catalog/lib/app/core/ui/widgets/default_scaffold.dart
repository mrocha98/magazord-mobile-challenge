import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/core/ui/constants/page_padding.dart';
import 'package:products_catalog/app/core/ui/widgets/default_navigation_bar.dart';

class DefaultScaffold extends StatelessWidget {
  const DefaultScaffold({
    required this.title,
    required this.body,
    super.key,
  });

  final String title;

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: goRouter.canPop()
            ? BackButton(
                onPressed: goRouter.pop,
              )
            : null,
        title: Text(title),
      ),
      body: Padding(
        padding: kPagePadding,
        child: body,
      ),
      bottomNavigationBar: const DefaultNavigationBar(),
    );
  }
}
