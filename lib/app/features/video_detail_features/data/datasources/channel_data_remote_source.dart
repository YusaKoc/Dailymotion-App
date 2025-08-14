import 'package:dailymotion_app/app/features/video_detail_features/data/models/channel_model.dart';
import 'package:dio/dio.dart';

abstract class ChannelRemoteDataSource {
  Future<ChannelModel> fetchChannelDetails(String channelId);
}

class ChannelRemoteDataSourceImpl implements ChannelRemoteDataSource {
  final Dio dio;

  ChannelRemoteDataSourceImpl(this.dio);

  @override
  Future<ChannelModel> fetchChannelDetails(String channelId) async {
    final response = await dio.get(
      'https://api.dailymotion.com/user/$channelId',
      queryParameters: {
        'fields':
            'id,screenname,avatar_120_url,cover_200_url,description,verified,url',
      },
    );

    return ChannelModel.fromJson(response.data);
  }
}
