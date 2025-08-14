import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/datasources/channel_remote_data_sources.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/data/entities/channel_entitiy.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ChannelVideosRepository {
  Future<Either<Failure, List<ChannelVideoEntity>>> fetchVideos(
      String owner, int page);
}

class ChannelVideosRepositoryImpl implements ChannelVideosRepository {
  final ChannelVideosRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChannelVideosRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<ChannelVideoEntity>>> fetchVideos(
      String owner, int page) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure("İnternet bağlantısı yok."));
      }
      final list = await remoteDataSource.fetchChannelVideos(owner, page);
      return Right(list);
    } on DioException {
      return const Left(ServerFailure("Sunucuya erişilemedi."));
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
