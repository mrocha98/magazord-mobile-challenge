import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_catalog/app/app_router.dart';
import 'package:products_catalog/app/core/ui/theme/bloc/theme_mode_bloc.dart';
import 'package:products_catalog/app/core/ui/theme/catppuccin_theme.dart';
import 'package:products_catalog/app/models/theme_flavor.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      context.read<ThemeModeBloc>().add(const ThemeModeInitialized());
    });
  }

  static final _theme = CatppuccinTheme.getTheme(ThemeFlavor.latte);

  static final _darkTheme = CatppuccinTheme.getTheme(ThemeFlavor.frappe);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, themeMode) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: _theme,
          darkTheme: _darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
