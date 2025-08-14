import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/datasources/channel_data_remote_source.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChannelRepository {
  Future<Either<Failure, ChannelEntity>> getChannel(String channelId);
}

class ChannelRepositoryImpl implements ChannelRepository {
  final ChannelRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChannelRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChannelEntity>> getChannel(String channelId) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure("İnternet bağlantısı yok."));
      }
      final channel = await remoteDataSource.fetchChannelDetails(channelId);
      return Right(channel);
    } on DioException {
      return const Left(ServerFailure("Sunucuya erişilemedi."));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
