import 'package:dailymotion_app/app/features/channel_detail_features/data/usecases/channel_video_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'channel_video_state.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/usecases/get_channel_detail.dart';

class ChannelVideosCubit extends Cubit<ChannelVideosState> {
  final FetchChannelVideos fetchChannelVideos;
  final GetChannelDetail getChannelDetail;

  ChannelVideosCubit(this.fetchChannelVideos, this.getChannelDetail)
      : super(const ChannelVideosState());

  int _currentPage = 1;

  Future<void> loadInitial(String owner) async {
    emit(state.copyWith(status: ChannelVideosStatus.loading, videos: []));
    _currentPage = 1;

    final channelResult = await getChannelDetail(owner);

    final videosResult = await fetchChannelVideos(owner, _currentPage);

    channelResult.fold((failure) {
      emit(state.copyWith(
        status: ChannelVideosStatus.error,
      ));
    }, (channel) {
      videosResult.fold((failure) {
        emit(state.copyWith(
          status: ChannelVideosStatus.error,
          channel: channel,
        ));
      }, (videos) {
        emit(state.copyWith(
          status: ChannelVideosStatus.success,
          videos: videos,
          hasMore: videos.length == 20,
          channel: channel,
        ));
      });
    });
  }

  Future<void> loadMore(String owner) async {
    if (!state.hasMore || state.status == ChannelVideosStatus.loadingMore)
      return;

    emit(state.copyWith(status: ChannelVideosStatus.loadingMore));
    _currentPage += 1;

    final result = await fetchChannelVideos(owner, _currentPage);

    result.fold((_) {
      _currentPage -= 1;
      emit(state.copyWith(status: ChannelVideosStatus.success));
    }, (moreVideos) {
      emit(state.copyWith(
        status: ChannelVideosStatus.success,
        videos: [...state.videos, ...moreVideos],
        hasMore: moreVideos.length == 20,
      ));
    });
  }

  Future<void> refresh(String owner) async {
    await loadInitial(owner);
  }
}
