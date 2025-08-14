import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/widgets/subs_button.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';

class ChannelInfoWidget extends StatelessWidget {
  final ChannelEntity channel;

  const ChannelInfoWidget({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: AppPadding.channelHeader,
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.channelDetail,
          arguments: channel.id,
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(channel.avatarUrl),
        radius: 24,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              channel.screenName,
              style: AppTextStyles.titleMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (channel.verified)
            const Padding(
              padding: AppPadding.onlyLeftSmall,
              child: Icon(Icons.verified, size: 18, color: Colors.blue),
            ),
        ],
      ),
      subtitle: Text(
        channel.description,
        style: AppTextStyles.bodySmall(context),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SubscriptionButton(
        channelId: channel.id,
        screenName: channel.screenName,
        avatarUrl: channel.avatarUrl,
      ),
    );
  }
}
