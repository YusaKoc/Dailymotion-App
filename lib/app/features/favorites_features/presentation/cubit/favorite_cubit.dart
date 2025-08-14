import 'dart:async';

import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/repository/favori_repository.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/usecase/favori_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AddFavorite addFavorite;
  final RemoveFavorite removeFavorite;
  final GetFavorites getFavorites;
  final IsFavorite isFavorite;
  final FavoriteRepository repo;

  FavoriteCubit({
    required this.addFavorite,
    required this.removeFavorite,
    required this.getFavorites,
    required this.isFavorite,
    required this.repo,
  }) : super(FavoriteInitial());

  List<FavoriteEntity> _allFavorites = [];
  StreamSubscription<Either<Failure, List<FavoriteEntity>>>? _sub;
  Timer? _debounce;
  String _search = '';

  void startListening() {
    emit(FavoriteLoading());
    _sub?.cancel();
    _sub = repo.favoritesStream().listen((either) {
      either.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (list) {
          _allFavorites = list;
          _emitFiltered();
        },
      );
    });
  }

  Future<void> loadFavoritesOnce() async {
    emit(FavoriteLoading());
    final result = await getFavorites();
    result.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (list) {
        _allFavorites = list;
        _emitFiltered();
      },
    );
  }

  void updateSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search = value;
      _emitFiltered();
    });
  }

  void _emitFiltered() {
    final q = _search.toLowerCase();
    final filtered = q.isEmpty
        ? _allFavorites
        : _allFavorites
            .where((f) => f.title.toLowerCase().contains(q))
            .toList();
    emit(FavoriteLoaded(filtered, search: _search));
  }

  bool isFavLocal(String videoId) {
    return _allFavorites.any((e) => e.videoId == videoId);
  }

  Future<void> toggleFavorite(FavoriteEntity video) async {
    final currentlyFav = isFavLocal(video.videoId);
    final res = currentlyFav
        ? await removeFavorite(video.videoId)
        : await addFavorite(video);

    res.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (_) {/**/},
    );
  }

  @override
  Future<void> close() async {
    _debounce?.cancel();
    await _sub?.cancel();
    return super.close();
  }
}
