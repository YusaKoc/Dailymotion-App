import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class SearchOfflineBanner extends StatelessWidget {
  const SearchOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.defaultPadding,
      color: Colors.orange.withOpacity(0.1),
      child: const Text(
        "İnternet bağlantısı yok.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.orange),
      ),
    );
  }
}
