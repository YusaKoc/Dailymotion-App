import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/repository/channel_repository.dart';
import 'package:dartz/dartz.dart';

class GetChannelDetail {
  final ChannelRepository repository;

  GetChannelDetail(this.repository);

  Future<Either<Failure, ChannelEntity>> call(String channelId) {
    return repository.getChannel(channelId);
  }
}
