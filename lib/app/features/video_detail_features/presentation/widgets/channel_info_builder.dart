import 'package:dailymotion_app/app/features/video_detail_features/presentation/cubit/channel_cubit.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/widgets/channel_info_widget.dart';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChannelInfoBuilder extends StatelessWidget {
  final ChannelCubit cubit;

  const ChannelInfoBuilder({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChannelCubit, ChannelState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is ChannelLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChannelLoaded) {
          return ChannelInfoWidget(channel: state.channel);
        } else if (state is ChannelError) {
          return const AppErrorHandlingChannel();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
