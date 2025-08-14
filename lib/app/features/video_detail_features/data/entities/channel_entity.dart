import 'package:equatable/equatable.dart';

class ChannelEntity extends Equatable {
  final String id;
  final String screenName;
  final String avatarUrl;
  final String coverUrl;
  final String description;
  final bool verified;
  final String url;

  const ChannelEntity({
    required this.id,
    required this.screenName,
    required this.avatarUrl,
    required this.coverUrl,
    required this.description,
    required this.verified,
    required this.url,
  });

  @override
  List<Object?> get props => [
        id,
        screenName,
        avatarUrl,
        coverUrl,
        description,
        verified,
        url,
      ];
}
