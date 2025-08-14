import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/widgets/video_card.dart';
import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  final ScrollController controller;
  final List<VideoEntity> videos;
  final bool isOffline;
  final bool isLoadingMore;

  const SearchResultsList({
    super.key,
    required this.controller,
    required this.videos,
    required this.isOffline,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    final itemCount = videos.length + (isLoadingMore ? 1 : 0);

    return ListView.builder(
      controller: controller,
      padding: AppPadding.onlyBottomLarge,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < videos.length) {
          return VideoCard(video: videos[index], isOffline: isOffline);
        } else {
          return const Padding(
            padding: AppPadding.vertical16,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
