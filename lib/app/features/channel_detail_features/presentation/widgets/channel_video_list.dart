import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/cubit/channel_video_cubit.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/cubit/channel_video_state.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/widgets/channel_video_card.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/widgets/header.dart';
import 'package:flutter/material.dart';

class ChannelVideosList extends StatefulWidget {
  final ChannelVideosCubit cubit;
  final String channelId;
  final ChannelVideosState state;

  const ChannelVideosList({
    super.key,
    required this.cubit,
    required this.channelId,
    required this.state,
  });

  @override
  State<ChannelVideosList> createState() => _ChannelVideosListState();
}

class _ChannelVideosListState extends State<ChannelVideosList> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300) {
          widget.cubit.loadMore(widget.channelId);
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() => widget.cubit.refresh(widget.channelId);

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.videos.length + (state.hasMore ? 2 : 1),
        itemBuilder: (context, index) {
          if (index == 0 && state.channel != null) {
            return ChannelHeaderWidget(channel: state.channel!);
          } else if (index <= state.videos.length) {
            return ChannelVideoCard(
              video: state.videos[index - 1],
              channelId: widget.channelId,
            );
          } else {
            return const Padding(
              padding: AppPadding.defaultPadding,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
