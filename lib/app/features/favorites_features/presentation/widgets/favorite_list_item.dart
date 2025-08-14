import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/widgets/channel_title.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FavoriteListItem extends StatelessWidget {
  final FavoriteEntity video;

  const FavoriteListItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/video-detail',
          arguments: VideoEntity(
            id: video.videoId,
            title: video.title,
            url: video.videoUrl,
            thumbnailUrl: video.thumbnailUrl,
            language: '',
            owner: video.owner,
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            if (video.thumbnailUrl.isNotEmpty)
              Image.network(
                video.thumbnailUrl,
                width: double.infinity,
                height: context.sized.dynamicHeight(0.3),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: double.infinity,
                  height: context.sized.dynamicHeight(0.3),
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image),
                ),
              )
            else
              Container(
                width: 110,
                height: 70,
                color: Colors.grey.shade200,
                child: const Icon(Icons.video_file, size: 40),
              ),
            const SizedBox(width: 12),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: AppPadding.defaultPadding,
                    child: Text(video.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium(context)),
                  ),
                ),
                const Padding(
                  padding: AppPadding.onlyRight,
                  child: Icon(Icons.favorite, color: Colors.red),
                ),
              ],
            ),
            ChannelTitle(
              ownerId: video.owner,
            )
          ],
        ),
      ),
    );
  }
}
