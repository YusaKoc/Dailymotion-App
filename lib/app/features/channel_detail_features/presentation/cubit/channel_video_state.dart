import 'package:dailymotion_app/app/features/channel_detail_features/data/entities/channel_entitiy.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:equatable/equatable.dart';

enum ChannelVideosStatus { initial, loading, success, error, loadingMore }

class ChannelVideosState extends Equatable {
  final List<ChannelVideoEntity> videos;
  final ChannelVideosStatus status;
  final bool hasMore;
  final ChannelEntity? channel;

  const ChannelVideosState({
    this.videos = const [],
    this.status = ChannelVideosStatus.initial,
    this.hasMore = true,
    this.channel,
  });

  ChannelVideosState copyWith({
    List<ChannelVideoEntity>? videos,
    ChannelVideosStatus? status,
    bool? hasMore,
    ChannelEntity? channel,
  }) {
    return ChannelVideosState(
      videos: videos ?? this.videos,
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      channel: channel ?? this.channel,
    );
  }

  @override
  List<Object?> get props => [videos, status, hasMore, channel];
}
