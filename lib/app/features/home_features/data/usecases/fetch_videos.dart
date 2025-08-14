import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dartz/dartz.dart';

import '../remote/entities/video_fetch_result.dart';
import '../repository/videp_repo.dart';

class FetchVideos {
  final VideoRepository repository;
  FetchVideos(this.repository);

  Future<Either<Failure, VideoFetchResult>> call(String category,
      {int page = 1}) {
    return repository.fetchVideos(category, page: page);
  }
}
