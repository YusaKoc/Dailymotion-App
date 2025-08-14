import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AppTextStyles {
  static TextStyle heading1Bold(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: context.sized.dynamicWidth(0.05));
  }

  static TextStyle titleMedium(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith();
  }

  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith();
  }

  static TextStyle heading1(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!.copyWith();
  }

  static TextStyle heading2(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        );
  }

  static TextStyle body(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 16,
        );
  }

  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 14,
        );
  }

  static TextStyle caption(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 12,
        );
  }

  static TextStyle textButton(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        );
  }
}
