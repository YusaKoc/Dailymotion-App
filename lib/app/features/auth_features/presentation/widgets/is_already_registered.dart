import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';

class IsAlreadyRegistered extends StatelessWidget {
  const IsAlreadyRegistered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Text(
        "Zaten Hesabım Var",
        style: AppTextStyles.textButton(context),
      ),
    );
  }
}
