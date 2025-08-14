import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';
import 'package:dailymotion_app/app/features/video_detail_features/data/usecases/get_channel_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<ChannelState> {
  final GetChannelDetail getChannelDetail;

  ChannelCubit(this.getChannelDetail) : super(const ChannelInitial());

  Future<void> fetchChannel(String id) async {
    emit(const ChannelLoading());

    final result = await getChannelDetail(id);

    result.fold(
      (failure) => emit(ChannelError(
        failure.message.isNotEmpty
            ? failure.message
            : AppConstants.errorMessage,
      )),
      (channel) => emit(ChannelLoaded(channel)),
    );
  }
}
