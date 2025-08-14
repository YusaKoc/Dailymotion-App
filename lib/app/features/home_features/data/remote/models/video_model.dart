import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    required super.id,
    required super.title,
    required super.thumbnailUrl,
    required super.url,
    required super.language,
    required super.owner,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnailUrl: json['thumbnail_url'] ?? '',
      url: json['url'] ?? '',
      language: json['language'] ?? '',
      owner: json['owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail_url': thumbnailUrl,
      'url': url,
      'language': language,
      'owner': owner,
    };
  }
}
