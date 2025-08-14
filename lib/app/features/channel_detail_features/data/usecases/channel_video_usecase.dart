import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/entities/channel_entitiy.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/repository/channel_video_repo.dart';
import 'package:dartz/dartz.dart';

class FetchChannelVideos {
  final ChannelVideosRepository repository;
  FetchChannelVideos(this.repository);

  Future<Either<Failure, List<ChannelVideoEntity>>> call(
      String owner, int page) {
    return repository.fetchVideos(owner, page);
  }
}
