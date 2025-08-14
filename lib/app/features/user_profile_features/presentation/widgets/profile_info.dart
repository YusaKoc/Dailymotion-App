import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String email;

  const ProfileInfo({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: AppTextStyles.heading1(context)),
        const SizedBox(height: 8),
        Text(
          email,
          style: AppTextStyles.bodyMedium(context),
        ),
      ],
    );
  }
}
