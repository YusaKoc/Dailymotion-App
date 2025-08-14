import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_cubit.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_state.dart';

import 'package:dailymotion_app/app/features/home_features/presentation/widgets/video_card.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListView extends StatefulWidget {
  final VideoCubit videoCubit;
  final String selectedCategory;

  const VideoListView({
    super.key,
    required this.videoCubit,
    required this.selectedCategory,
  });

  @override
  State<VideoListView> createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      widget.videoCubit.loadMore(widget.selectedCategory);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      bloc: widget.videoCubit,
      builder: (context, state) {
        if (state.status == VideoStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == VideoStatus.error) {
          return Center(
            child: Text(
              state.errorMessage ?? "Bir hata oluştu.",
              style: AppTextStyles.bodyMedium(context),
            ),
          );
        }

        if (state.videos.isEmpty) {
          return Center(
            child: Text(
              "Görüntülenecek video yok.",
              style: AppTextStyles.heading2(context),
            ),
          );
        }

        return Column(
          children: [
            if (state.isOffline)
              Container(
                width: double.infinity,
                color: Colors.red.shade600,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.wifi_off, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                          "İnternet bağlantısı yok, önbellekten gösteriliyor.",
                          style: AppTextStyles.body(context)),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    widget.videoCubit.refresh(widget.selectedCategory),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.videos.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.videos.length) {
                      return VideoCard(
                        video: state.videos[index],
                        isOffline: state.isOffline,
                      );
                    } else {
                      return const Padding(
                        padding: AppPadding.defaultPadding,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
