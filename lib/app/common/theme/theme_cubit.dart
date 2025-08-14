import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box settingsBox;

  ThemeCubit(this.settingsBox)
      : super(settingsBox.get('isDark', defaultValue: false)
            ? ThemeMode.dark
            : ThemeMode.light);

  void toggleTheme() {
    final isDark = state == ThemeMode.dark;
    settingsBox.put('isDark', !isDark);
    emit(!isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
