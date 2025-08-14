import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/datasources/channel_data_remote_source.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:get_it/get_it.dart';

class ChannelTitle extends StatefulWidget {
  final String ownerId;

  const ChannelTitle({
    super.key,
    required this.ownerId,
  });

  @override
  State<ChannelTitle> createState() => _ChannelTitleState();
}

class _ChannelTitleState extends State<ChannelTitle> {
  late Future<ChannelEntity> _channelFuture;

  @override
  void initState() {
    super.initState();
    _channelFuture =
        GetIt.I<ChannelRemoteDataSource>().fetchChannelDetails(widget.ownerId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChannelEntity>(
      future: _channelFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: AppPadding.smallPadding,
            child: LinearProgressIndicator(),
          );
        }

        final channel = snapshot.data!;
        return Padding(
          padding: AppPadding.channelTitle,
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  channel.avatarUrl,
                  width: context.sized.dynamicWidth(0.08),
                  height: context.sized.dynamicWidth(0.08),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.person),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  channel.screenName,
                  style: AppTextStyles.bodyMedium(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (channel.verified)
                const Icon(Icons.check_circle, color: Colors.blue, size: 18),
            ],
          ),
        );
      },
    );
  }
}
