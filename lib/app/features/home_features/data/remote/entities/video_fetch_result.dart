import 'video_entity.dart';

class VideoFetchResult {
  final List<VideoEntity> videos;
  final bool isOffline;

  const VideoFetchResult({
    required this.videos,
    required this.isOffline,
  });
}
