import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dartz/dartz.dart';

import '../remote/entities/video_entity.dart';
import '../remote/entities/video_fetch_result.dart';

abstract class VideoRepository {
  Future<Either<Failure, VideoFetchResult>> fetchVideos(String category,
      {int page = 1});
  Future<Either<Failure, List<VideoEntity>>> searchVideos(String query,
      {int page = 1});
}
