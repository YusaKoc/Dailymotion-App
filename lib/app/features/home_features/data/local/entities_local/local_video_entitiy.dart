import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';

class LocalVideoEntity extends VideoEntity {
  final String category;

  const LocalVideoEntity({
    required super.id,
    required super.title,
    required super.thumbnailUrl,
    required this.category,
    super.url = '',
    super.language = '',
    super.owner = '',
  });

  factory LocalVideoEntity.fromMap(Map<String, dynamic> map) {
    return LocalVideoEntity(
      id: map['id'],
      title: map['title'],
      thumbnailUrl: map['thumbnailUrl'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
    };
  }
}
