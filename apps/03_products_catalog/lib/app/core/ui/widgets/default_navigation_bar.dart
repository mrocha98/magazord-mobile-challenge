import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:products_catalog/app/features/configs/configs_router.dart';
import 'package:products_catalog/app/features/products/products_router.dart';

class DefaultNavigationBar extends StatefulWidget {
  const DefaultNavigationBar({super.key});

  @override
  State<DefaultNavigationBar> createState() => _DefaultNavigationBarState();
}

class _DefaultNavigationBarState extends State<DefaultNavigationBar>
    with AfterLayoutMixin {
  late GoRouter _goRouter;

  int _selectedIndex = 0;

  @override
  void afterFirstLayout(BuildContext context) {
    _goRouter = GoRouter.of(context)
      ..routeInformationProvider.addListener(_routeChangeListener);
  }

  @override
  void dispose() {
    _goRouter.routeInformationProvider.removeListener(_routeChangeListener);
    super.dispose();
  }

  void _routeChangeListener() {
    final activeRoute = _goRouter.routeInformationProvider.value.uri.toString();
    setState(() {
      _selectedIndex = switch (activeRoute) {
        ConfigsRouter.path => 1,
        _ => 0,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        if (index == _selectedIndex) return;

        final location = switch (index) {
          1 => ConfigsRouter.path,
          _ => ProductsRouter.path,
        };
        _goRouter.push(location);
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.shopping_cart),
          label: 'Products',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Configs',
        ),
      ],
    );
  }
}
