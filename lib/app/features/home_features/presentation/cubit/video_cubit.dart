import 'package:dailymotion_app/app/features/home_features/data/usecases/fetch_videos.dart';
import 'package:dailymotion_app/app/features/home_features/data/usecases/search_usecase.dart';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final FetchVideos fetchVideosUseCase;
  final SearchVideos searchVideosUseCase;

  int _currentPage = 1;
  bool _isFetchingMore = false;

  VideoCubit(this.fetchVideosUseCase, this.searchVideosUseCase)
      : super(const VideoState());

  Future<void> loadVideos(String category) async {
    _currentPage = 1;
    final isInitial = state.videos.isEmpty;
    if (isInitial) {
      emit(state.copyWith(status: VideoStatus.loading));
    }

    final result = await fetchVideosUseCase(category, page: _currentPage);

    result.fold((failure) {
      emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: failure.message.isNotEmpty
            ? failure.message
            : AppConstants.errorMessage,
      ));
    }, (data) {
      emit(state.copyWith(
        status: VideoStatus.success,
        videos: data.videos,
        isOffline: data.isOffline,
        errorMessage: '',
      ));
    });
  }

  Future<void> loadMore(String category) async {
    if (_isFetchingMore || state.status == VideoStatus.loading) return;
    _isFetchingMore = true;
    _currentPage++;

    final result = await fetchVideosUseCase(category, page: _currentPage);

    result.fold((_) {
      _currentPage--;
    }, (data) {
      emit(state.copyWith(videos: [...state.videos, ...data.videos]));
    });

    _isFetchingMore = false;
  }

  Future<void> refresh(String category) async {
    await loadVideos(category);
  }

  Future<void> search(String query) async {
    _currentPage = 1;
    emit(state.copyWith(status: VideoStatus.loading));

    final result = await searchVideosUseCase(query, page: _currentPage);

    result.fold((failure) {
      emit(state.copyWith(
        status: VideoStatus.error,
        errorMessage: failure.message.isNotEmpty
            ? failure.message
            : AppConstants.errorMessage,
      ));
    }, (videos) {
      emit(state.copyWith(
        status: VideoStatus.success,
        videos: videos,
        isOffline: false,
        errorMessage: '',
      ));
    });
  }

  Future<void> loadMoreSearchResults(String query) async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    _currentPage++;

    final result = await searchVideosUseCase(query, page: _currentPage);

    result.fold((_) {
      _currentPage--;
    }, (more) {
      final existingIds = state.videos.map((v) => v.id).toSet();
      final unique = more.where((v) => !existingIds.contains(v.id)).toList();
      emit(state.copyWith(videos: [...state.videos, ...unique]));
    });

    _isFetchingMore = false;
  }

  void clearAndReload(String category) {
    emit(const VideoState());
    loadVideos(category);
  }

  void clear() {
    emit(const VideoState());
  }
}
