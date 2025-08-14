import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_input_styles.dart';
import 'package:flutter/material.dart';

class SubsSearchBar extends StatelessWidget {
  final void Function(String) onSearch;

  const SubsSearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.defaultPadding,
      child: TextField(
          onChanged: onSearch,
          decoration: AppInputStyles.inputDecoration(context,
              hint: 'Kanal Ara', icon: Icons.search)),
    );
  }
}
