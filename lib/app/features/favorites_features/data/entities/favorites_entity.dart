import 'package:equatable/equatable.dart';

class FavoriteEntity extends Equatable {
  final String videoId;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final String owner;

  const FavoriteEntity({
    required this.videoId,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.owner,
  });

  @override
  List<Object?> get props => [videoId, title, thumbnailUrl, videoUrl, owner];
}
