import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006971),
      surfaceTint: Color(0xff006971),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df0fa),
      onPrimaryContainer: Color(0xff004f56),
      secondary: Color(0xff4a6366),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcde7eb),
      onSecondaryContainer: Color(0xff324b4e),
      tertiary: Color(0xff505e7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd8e2ff),
      onTertiaryContainer: Color(0xff394764),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbec8c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3132),
      inversePrimary: Color(0xff81d3dd),
      primaryFixed: Color(0xff9df0fa),
      onPrimaryFixed: Color(0xff001f23),
      primaryFixedDim: Color(0xff81d3dd),
      onPrimaryFixedVariant: Color(0xff004f56),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff051f22),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff324b4e),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff0c1b36),
      tertiaryFixedDim: Color(0xffb8c6ea),
      onTertiaryFixedVariant: Color(0xff394764),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee4e4),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003d42),
      surfaceTint: Color(0xff006971),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff177881),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff223a3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff587175),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff283653),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5f6d8d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff0c1213),
      onSurfaceVariant: Color(0xff2f3839),
      outline: Color(0xff4b5455),
      outlineVariant: Color(0xff656f70),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3132),
      inversePrimary: Color(0xff81d3dd),
      primaryFixed: Color(0xff177881),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005e66),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff587175),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff40595c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5f6d8d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff475573),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1c8c8),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f5),
      surfaceContainer: Color(0xffe3e9ea),
      surfaceContainerHigh: Color(0xffd8dedf),
      surfaceContainerHighest: Color(0xffcdd3d3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003236),
      surfaceTint: Color(0xff006971),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff005158),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff173033),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff354d50),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1e2c48),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3b4967),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e2f),
      outlineVariant: Color(0xff414b4c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3132),
      inversePrimary: Color(0xff81d3dd),
      primaryFixed: Color(0xff005158),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00393e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff354d50),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1e3639),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3b4967),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff24324f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4babb),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f2),
      surfaceContainer: Color(0xffdee4e4),
      surfaceContainerHigh: Color(0xffcfd5d6),
      surfaceContainerHighest: Color(0xffc1c8c8),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff81d3dd),
      surfaceTint: Color(0xff81d3dd),
      onPrimary: Color(0xff00363b),
      primaryContainer: Color(0xff004f56),
      onPrimaryContainer: Color(0xff9df0fa),
      secondary: Color(0xffb1cbcf),
      onSecondary: Color(0xff1c3437),
      secondaryContainer: Color(0xff324b4e),
      onSecondaryContainer: Color(0xffcde7eb),
      tertiary: Color(0xffb8c6ea),
      onTertiary: Color(0xff22304c),
      tertiaryContainer: Color(0xff394764),
      onTertiaryContainer: Color(0xffd8e2ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee4e4),
      onSurfaceVariant: Color(0xffbec8c9),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e4),
      inversePrimary: Color(0xff006971),
      primaryFixed: Color(0xff9df0fa),
      onPrimaryFixed: Color(0xff001f23),
      primaryFixedDim: Color(0xff81d3dd),
      onPrimaryFixedVariant: Color(0xff004f56),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff051f22),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff324b4e),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff0c1b36),
      tertiaryFixedDim: Color(0xffb8c6ea),
      onTertiaryFixedVariant: Color(0xff394764),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff97eaf4),
      surfaceTint: Color(0xff81d3dd),
      onPrimary: Color(0xff002b2f),
      primaryContainer: Color(0xff489da6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc6e1e5),
      onSecondary: Color(0xff10292c),
      secondaryContainer: Color(0xff7c9599),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcfdcff),
      onTertiary: Color(0xff172541),
      tertiaryContainer: Color(0xff8391b2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd4dedf),
      outline: Color(0xffaab4b5),
      outlineVariant: Color(0xff889293),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e4),
      inversePrimary: Color(0xff005057),
      primaryFixed: Color(0xff9df0fa),
      onPrimaryFixed: Color(0xff001417),
      primaryFixedDim: Color(0xff81d3dd),
      onPrimaryFixedVariant: Color(0xff003d42),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff001417),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff223a3d),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff02102c),
      tertiaryFixedDim: Color(0xffb8c6ea),
      onTertiaryFixedVariant: Color(0xff283653),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff3f4646),
      surfaceContainerLowest: Color(0xff040809),
      surfaceContainerLow: Color(0xff181f1f),
      surfaceContainer: Color(0xff23292a),
      surfaceContainerHigh: Color(0xff2d3434),
      surfaceContainerHighest: Color(0xff383f40),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7f9ff),
      surfaceTint: Color(0xff81d3dd),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff7dcfd9),
      onPrimaryContainer: Color(0xff000e10),
      secondary: Color(0xffdaf5f8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffadc7cb),
      onSecondaryContainer: Color(0xff000e10),
      tertiary: Color(0xffecefff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb4c2e6),
      onTertiaryContainer: Color(0xff000a22),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe8f2f3),
      outlineVariant: Color(0xffbbc4c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4e4),
      inversePrimary: Color(0xff005057),
      primaryFixed: Color(0xff9df0fa),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff81d3dd),
      onPrimaryFixedVariant: Color(0xff001417),
      secondaryFixed: Color(0xffcde7eb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb1cbcf),
      onSecondaryFixedVariant: Color(0xff001417),
      tertiaryFixed: Color(0xffd8e2ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb8c6ea),
      onTertiaryFixedVariant: Color(0xff02102c),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff4b5152),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1a2121),
      surfaceContainer: Color(0xff2b3132),
      surfaceContainerHigh: Color(0xff363d3d),
      surfaceContainerHighest: Color(0xff424849),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
