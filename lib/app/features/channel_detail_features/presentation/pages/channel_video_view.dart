import 'package:dailymotion_app/app/common/widgets/subs_button.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/cubit/channel_video_cubit.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/cubit/channel_video_state.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/widgets/app_bar_logo.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/widgets/channel_video_list.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/widgets/error_view.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/widgets/loading_view.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/cubit/subs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChannelDetailPage extends StatefulWidget {
  final String channelId;
  const ChannelDetailPage({super.key, required this.channelId});

  @override
  State<ChannelDetailPage> createState() => _ChannelDetailPageState();
}

class _ChannelDetailPageState extends State<ChannelDetailPage> {
  late final ChannelVideosCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = GetIt.I<ChannelVideosCubit>();
    _cubit.loadInitial(widget.channelId);
    context.read<SubscriptionCubit>().watchAll();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
          bloc: _cubit,
          builder: (context, state) {
            if (state.channel == null) {
              return const ChannelAppBarLogo();
            }
            final ch = state.channel!;
            return ChannelAppBarLogo(
              extraActions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SubscriptionButton(
                    channelId: ch.id,
                    screenName: ch.screenName,
                    avatarUrl: ch.avatarUrl,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: BlocBuilder<ChannelVideosCubit, ChannelVideosState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state.status == ChannelVideosStatus.error &&
              state.videos.isEmpty) {
            return ChannelErrorView(
                onRetry: () => _cubit.loadInitial(widget.channelId));
          }
          if (state.status == ChannelVideosStatus.loading &&
              state.videos.isEmpty) {
            return const ChannelLoadingView();
          }
          return ChannelVideosList(
            cubit: _cubit,
            channelId: widget.channelId,
            state: state,
          );
        },
      ),
    );
  }
}
