import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/entities/channel_entitiy.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';

class ChannelVideoCard extends StatelessWidget {
  final ChannelVideoEntity video;
  final String channelId;

  const ChannelVideoCard({
    super.key,
    required this.video,
    required this.channelId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final videoEntity = VideoEntity(
          id: video.id,
          title: video.title,
          url: video.url,
          thumbnailUrl: video.thumbnailUrl,
          language: '',
          owner: channelId,
        );
        Navigator.pushNamed(
          context,
          AppRoutes.videoDetail,
          arguments: videoEntity,
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.network(
                video.thumbnailUrl,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 120,
                  height: 80,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: AppPadding.onlyRight,
                child: Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyMedium(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
