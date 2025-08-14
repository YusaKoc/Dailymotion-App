import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';

class FavoriteVideoModel extends FavoriteEntity {
  const FavoriteVideoModel(
      {required super.videoId,
      required super.title,
      required super.thumbnailUrl,
      required super.videoUrl,
      required super.owner});

  factory FavoriteVideoModel.fromJson(Map<String, dynamic> json) {
    return FavoriteVideoModel(
        videoId: json['id'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'],
        videoUrl: json['url'],
        owner: json['owner']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': videoId,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'url': videoUrl,
      'owner': owner,
    };
  }
}
