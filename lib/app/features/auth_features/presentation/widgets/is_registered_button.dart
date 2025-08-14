import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';

class IsRegistered extends StatelessWidget {
  const IsRegistered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/register');
      },
      child: Text(
        "Hesap Oluştur",
        style: AppTextStyles.textButton(context),
      ),
    );
  }
}
