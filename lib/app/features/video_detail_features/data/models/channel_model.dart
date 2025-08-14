import 'package:dailymotion_app/app/features/video_detail_features/data/entities/channel_entity.dart';

class ChannelModel extends ChannelEntity {
  const ChannelModel({
    required super.id,
    required super.screenName,
    required super.avatarUrl,
    required super.coverUrl,
    required super.description,
    required super.verified,
    required super.url,
  });

  factory ChannelModel.fromJson(Map<String, dynamic> json) {
    return ChannelModel(
      id: json['id'],
      screenName: json['screenname'],
      avatarUrl: json['avatar_120_url'] ?? '',
      coverUrl: json['cover_200_url'] ?? '',
      description: json['description'] ?? '',
      verified: json['verified'] ?? false,
      url: json['url'],
    );
  }
}
