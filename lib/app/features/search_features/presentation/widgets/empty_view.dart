import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

class SearchEmptyView extends StatelessWidget {
  final bool isOffline;
  const SearchEmptyView({super.key, required this.isOffline});

  @override
  Widget build(BuildContext context) {
    final message = isOffline
        ? "İnternet yok, eşleşen yerel video bulunamadı."
        : "Aramaya Başlayın!";

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/search_lottie.json',
            width: context.sized.dynamicWidth(0.7),
          ),
          Text(message, style: AppTextStyles.heading2(context)),
        ],
      ),
    );
  }
}
