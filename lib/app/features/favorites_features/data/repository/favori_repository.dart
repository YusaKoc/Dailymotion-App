import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/datasources/favori_remote_data_source.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, void>> addFavorite(FavoriteEntity video);
  Future<Either<Failure, void>> removeFavorite(String videoId);
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites();
  Future<Either<Failure, bool>> isFavorite(String videoId);
  Stream<Either<Failure, List<FavoriteEntity>>> favoritesStream();
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remote;
  final NetworkInfo networkInfo;
  FavoriteRepositoryImpl(this.remote, this.networkInfo);

  @override
  Stream<Either<Failure, List<FavoriteEntity>>> favoritesStream() async* {
    try {
      yield* remote.getFavoritesStream().map((items) => Right(items));
    } on FirebaseAuthException {
      yield const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      yield const Left(ServerFailure());
    } catch (_) {
      yield const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(FavoriteEntity video) async {
    try {
      if (!await networkInfo.isConnected) return const Left(NetworkFailure());
      await remote.toggleFavorite(video);
      return const Right(null);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(String videoId) async {
    try {
      if (!await networkInfo.isConnected) return const Left(NetworkFailure());
      await remote.toggleFavorite(
        FavoriteEntity(
          videoId: videoId,
          title: '',
          thumbnailUrl: '',
          videoUrl: '',
          owner: '',
        ),
      );
      return const Right(null);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<FavoriteEntity>>> getFavorites() async {
    try {
      final list = await remote.getFavorites();
      return Right(list);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String videoId) async {
    try {
      final ok = await remote.isFavorite(videoId);
      return Right(ok);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
