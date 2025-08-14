import 'package:equatable/equatable.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';

enum VideoStatus { initial, loading, success, error }

class VideoState extends Equatable {
  final List<VideoEntity> videos;
  final VideoStatus status;
  final String? errorMessage;
  final bool isOffline;

  const VideoState({
    this.videos = const [],
    this.status = VideoStatus.initial,
    this.errorMessage,
    this.isOffline = false,
  });

  VideoState copyWith({
    List<VideoEntity>? videos,
    VideoStatus? status,
    String? errorMessage,
    bool? isOffline,
  }) {
    return VideoState(
      videos: videos ?? this.videos,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [videos, status, errorMessage, isOffline];
}
