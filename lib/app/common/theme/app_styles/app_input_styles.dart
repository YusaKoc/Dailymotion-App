import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppInputStyles {
  static InputDecoration inputDecoration(
    BuildContext context, {
    required String hint,
    IconData? icon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, color: theme.iconTheme.color?.withOpacity(0.7))
          : null,
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor ?? colorScheme.surface,
      contentPadding: AppPadding.inputPadding,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: theme.dividerColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colorScheme.primary,
          width: 2,
        ),
      ),
      hintStyle: theme.textTheme.bodyLarge
          ?.copyWith(color: theme.hintColor, fontWeight: FontWeight.bold),
    );
  }
}
