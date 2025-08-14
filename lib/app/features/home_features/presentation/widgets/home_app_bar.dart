import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/constants/enum/category_enum.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<HomeCategory> categories;

  const HomeAppBar({
    super.key,
    required this.controller,
    required this.categories,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppConstants.appName,
          style: AppTextStyles.heading1Bold(
            context,
          ).copyWith(fontWeight: FontWeight.bold)),
      bottom: TabBar(
        isScrollable: true,
        controller: controller,
        tabs: categories.map((c) => Tab(text: c.upperName)).toList(),
      ),
    );
  }
}
