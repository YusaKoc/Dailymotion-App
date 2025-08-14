import 'package:dailymotion_app/app/features/channel_detail_features/data/models/channel_video_model.dart';
import 'package:dio/dio.dart';

abstract class ChannelVideosRemoteDataSource {
  Future<List<ChannelVideoModel>> fetchChannelVideos(String owner, int page);
}

class ChannelVideosRemoteDataSourceImpl
    implements ChannelVideosRemoteDataSource {
  final Dio dio;

  ChannelVideosRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ChannelVideoModel>> fetchChannelVideos(
      String owner, int page) async {
    final response = await dio.get(
      'https://api.dailymotion.com/user/$owner/videos',
      queryParameters: {
        'fields': 'id,title,thumbnail_url,url,channel',
        'limit': 20,
        'page': page,
      },
    );

    final List list = response.data['list'];
    return list.map((e) => ChannelVideoModel.fromJson(e)).toList();
  }
}
