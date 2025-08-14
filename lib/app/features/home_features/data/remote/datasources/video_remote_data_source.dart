import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dio/dio.dart';
import '../models/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoEntity>> fetchVideos(String category, {int page});
  Future<List<VideoEntity>> searchVideos(String query, {int page});
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio dio;

  VideoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<VideoEntity>> fetchVideos(String category, {int page = 1}) async {
    final response = await dio.get(
      'https://api.dailymotion.com/videos',
      queryParameters: {
        'fields': 'id,title,thumbnail_url,url,channel.id,owner',
        'channel': category,
        'limit': 20,
        'page': page,
        'localization': 'us',
      },
    );

    final List videos = response.data['list'];
    return videos.map((e) => VideoModel.fromJson(e)).toList();
  }

  @override
  Future<List<VideoEntity>> searchVideos(String query, {int page = 1}) async {
    final response = await dio.get(
      'https://api.dailymotion.com/videos',
      queryParameters: {
        'fields': 'id,title,thumbnail_url,url,channel.id,owner',
        'search': query,
        'limit': 20,
        'page': page,
        'localization': 'us',
      },
    );

    final List list = response.data['list'];
    return list.map((e) => VideoModel.fromJson(e)).toList();
  }
}
