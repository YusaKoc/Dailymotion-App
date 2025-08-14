import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';

class ChannelErrorView extends StatelessWidget {
  final VoidCallback onRetry;
  const ChannelErrorView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            "Sayfa yüklenemedi\nLütfen internet bağlantınızı kontrol edin.",
            textAlign: TextAlign.center,
            style: AppTextStyles.body(context),
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onRetry, child: const Text("Tekrar Dene")),
        ],
      ),
    );
  }
}
