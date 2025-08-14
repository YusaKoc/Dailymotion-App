import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ChannelHeaderWidget extends StatelessWidget {
  final ChannelEntity channel;

  const ChannelHeaderWidget({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (channel.coverUrl.isNotEmpty)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Image.network(
              channel.coverUrl,
              width: double.infinity,
              height: context.sized.dynamicHeight(0.22),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 160, color: Colors.grey.shade300),
            ),
          ),
        ListTile(
          contentPadding: AppPadding.channelHeader,
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(channel.avatarUrl),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  channel.screenName,
                  style: AppTextStyles.heading2(context),
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
          subtitle: Padding(
            padding: AppPadding.onlyTopSmall,
            child: Text(
              channel.description.isNotEmpty ? channel.description : "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall(context),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
