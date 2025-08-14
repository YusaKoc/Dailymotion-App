import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/widgets/channel_title.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/common/constants/app_assets.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:lottie/lottie.dart';

class VideoCard extends StatelessWidget {
  final VideoEntity video;
  final bool isOffline;

  const VideoCard({
    super.key,
    required this.video,
    required this.isOffline,
  });

  bool get hasValidUrl =>
      video.url.trim().isNotEmpty &&
      Uri.tryParse(video.url)?.hasAbsolutePath == true &&
      video.url.startsWith('http');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (isOffline || !hasValidUrl)
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        "İnternet Bağlantısı yok. Tekrar denemek için sayfayı yenileyin.")),
              );
            }
          : () {
              Navigator.pushNamed(
                context,
                AppRoutes.videoDetail,
                arguments: video,
              );
            },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Image.network(
                    video.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.broken_image, size: 40)),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: Lottie.asset(AppAssets.Splash, width: 80),
                      );
                    },
                  ),
                  const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 48,
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppPadding.defaultPadding,
              child: Text(
                video.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.titleMedium(context),
              ),
            ),
            ChannelTitle(
              ownerId: video.owner,
            ),
          ],
        ),
      ),
    );
  }
}
