import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/common/widgets/favorites_button.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';

class VideoTitleSection extends StatelessWidget {
  final String title;
  final VideoEntity video;

  const VideoTitleSection({
    super.key,
    required this.title,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.videoTitle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.heading2(context),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          FavoriteButton(video: video),
        ],
      ),
    );
  }
}
