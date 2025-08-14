import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String url;
  final String language;
  final String owner;

  const VideoEntity({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
    required this.language,
    required this.owner,
  });

  @override
  List<Object?> get props => [id, title, thumbnailUrl, url, language, owner];
}
