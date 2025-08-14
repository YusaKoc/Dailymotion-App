import 'package:flutter/material.dart';

class ProfileThemeSwitch extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const ProfileThemeSwitch({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Karanlık Tema"),
      value: isDark,
      onChanged: (_) => onToggle(),
    );
  }
}
