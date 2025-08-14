import 'package:equatable/equatable.dart';

class ChannelVideoEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String url;
  final String channel;
  final String screenName;
  final String avatarUrl;
  final String coverUrl;
  final String description;
  final bool verified;

  const ChannelVideoEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
    required this.channel,
    required this.screenName,
    required this.avatarUrl,
    required this.coverUrl,
    required this.description,
    required this.verified,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        thumbnailUrl,
        url,
        channel,
        screenName,
        avatarUrl,
        coverUrl,
        description,
        verified
      ];
}
