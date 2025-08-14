import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/features/home_features/data/repository/videp_repo.dart';
import 'package:dartz/dartz.dart';

class SearchVideos {
  final VideoRepository repository;
  SearchVideos(this.repository);

  Future<Either<Failure, List<VideoEntity>>> call(String query,
      {int page = 1}) {
    return repository.searchVideos(query, page: page);
  }
}
