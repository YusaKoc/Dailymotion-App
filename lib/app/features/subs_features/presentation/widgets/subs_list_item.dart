import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';

class SubscriptionListItem extends StatelessWidget {
  final SubscriptionEntity channel;

  const SubscriptionListItem({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.channelDetail,
          arguments: channel.channelId,
        );
      },
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(channel.avatarUrl),
      ),
      title: Text(
        channel.screenName,
        style: AppTextStyles.titleMedium(context),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
    );
  }
}
