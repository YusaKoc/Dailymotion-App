import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/repository/favori_repository.dart';
import 'package:dartz/dartz.dart';

class AddFavorite {
  final FavoriteRepository repo;
  AddFavorite(this.repo);
  Future<Either<Failure, void>> call(FavoriteEntity video) =>
      repo.addFavorite(video);
}

class RemoveFavorite {
  final FavoriteRepository repo;
  RemoveFavorite(this.repo);
  Future<Either<Failure, void>> call(String id) => repo.removeFavorite(id);
}

class GetFavorites {
  final FavoriteRepository repo;
  GetFavorites(this.repo);
  Future<Either<Failure, List<FavoriteEntity>>> call() => repo.getFavorites();
}

class IsFavorite {
  final FavoriteRepository repo;
  IsFavorite(this.repo);
  Future<Either<Failure, bool>> call(String id) => repo.isFavorite(id);
}
