import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';

class ChannelAppBarLogo extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? extraActions;

  const ChannelAppBarLogo({super.key, this.extraActions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      titleSpacing: 16,
      title: InkWell(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.navigator,
          (route) => false,
        ),
        child: Text(
          AppConstants.appName,
          style: AppTextStyles.heading1Bold(context),
        ),
      ),
      actions: [
        if (extraActions != null) ...extraActions!,
        IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.navigator,
              (route) => false,
            );
          },
          icon: const Icon(Icons.home),
        ),
      ],
    );
  }
}
