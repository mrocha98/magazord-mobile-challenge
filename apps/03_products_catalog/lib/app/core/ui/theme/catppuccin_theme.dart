import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:products_catalog/app/models/theme_flavor.dart';

sealed class CatppuccinTheme {
  static Flavor _getCatppuccinFlavor(ThemeFlavor themeFlavor) {
    return switch (themeFlavor) {
      ThemeFlavor.latte => catppuccin.latte,
      ThemeFlavor.frappe => catppuccin.frappe,
      ThemeFlavor.macchiato => catppuccin.macchiato,
      ThemeFlavor.mocha => catppuccin.mocha,
    };
  }

  static ThemeData getTheme(ThemeFlavor themeFlavor) {
    final flavor = _getCatppuccinFlavor(themeFlavor);
    final primaryColor = flavor.mauve;
    final secondaryColor = flavor.pink;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        background: flavor.base,
        brightness: Brightness.light,
        error: flavor.surface2,
        onBackground: flavor.text,
        onError: flavor.red,
        onPrimary: primaryColor,
        onSecondary: secondaryColor,
        onSurface: flavor.text,
        primary: flavor.crust,
        secondary: flavor.mantle,
        surface: flavor.surface0,
      ),
      scaffoldBackgroundColor: flavor.base,
      iconTheme: IconThemeData(
        color: flavor.text,
      ),
      appBarTheme: AppBarTheme(
        elevation: 1,
        titleTextStyle: TextStyle(
          color: flavor.text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: flavor.crust,
        foregroundColor: secondaryColor,
        centerTitle: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 1,
        backgroundColor: flavor.crust,
        indicatorColor: flavor.base,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: flavor.text,
        displayColor: primaryColor,
        fontFamily: 'Roboto',
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flavor.mantle,
          foregroundColor: secondaryColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: flavor.text,
        ),
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
        ),
      ),
      chipTheme: const ChipThemeData(
        padding: EdgeInsets.all(4),
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.zero,
        color: flavor.base,
      ),
    );
  }
}
