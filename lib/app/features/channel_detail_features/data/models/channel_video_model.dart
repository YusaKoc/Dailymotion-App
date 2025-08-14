import 'package:dailymotion_app/app/features/channel_detail_features/data/entities/channel_entitiy.dart';

class ChannelVideoModel extends ChannelVideoEntity {
  const ChannelVideoModel({
    required super.id,
    required super.title,
    required super.thumbnailUrl,
    required super.url,
    required super.channel,
    required super.screenName,
    required super.avatarUrl,
    required super.coverUrl,
    required super.description,
    required super.verified,
  });

  factory ChannelVideoModel.fromJson(Map<String, dynamic> json) {
    return ChannelVideoModel(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnail_url'] ?? '',
      url: json['url'],
      channel: json['channel'] ?? '',
      screenName: json['screen_name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      coverUrl: json['cover_url'] ?? '',
      description: json['description'] ?? '',
      verified: json['verified'] ?? false,
    );
  }
}
