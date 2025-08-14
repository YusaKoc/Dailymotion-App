import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../remote/datasources/video_remote_data_source.dart';
import '../remote/entities/video_entity.dart';
import '../remote/entities/video_fetch_result.dart';
import '../local/local_video_datasource/local_video_data_source.dart';
import 'videp_repo.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;
  final VideoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VideoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, VideoFetchResult>> fetchVideos(String category,
      {int page = 1}) async {
    try {
      final online = await networkInfo.isConnected;

      if (!online) {
        final cached = await localDataSource.getCachedVideos(category);
        if (cached.isNotEmpty) {
          return Right(VideoFetchResult(videos: cached, isOffline: true));
        } else {
          return const Left(NetworkFailure("İnternet yok ve önbellek boş."));
        }
      }

      final remote = await remoteDataSource.fetchVideos(category, page: page);

      if (page == 1) {
        await localDataSource.cacheVideos(category, remote);
      }

      return Right(VideoFetchResult(videos: remote, isOffline: false));
    } on DioException {
      final cached = await localDataSource.getCachedVideos(category);
      if (cached.isNotEmpty && page == 1) {
        return Right(VideoFetchResult(videos: cached, isOffline: true));
      }
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> searchVideos(String query,
      {int page = 1}) async {
    try {
      final online = await networkInfo.isConnected;
      if (!online)
        return const Left(NetworkFailure("Arama için internet gerekli."));

      final results = await remoteDataSource.searchVideos(query, page: page);
      return Right(results);
    } on DioException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
