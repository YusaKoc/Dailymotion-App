import 'package:dailymotion_app/app/features/home_features/data/local/entities_local/local_video_entitiy.dart';
import 'package:hive/hive.dart';

part 'local_video_model.g.dart';

@HiveType(typeId: 0)
class LocalVideoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnailUrl;

  @HiveField(3)
  final String category;

  LocalVideoModel(this.id, this.title, this.thumbnailUrl, this.category);

  LocalVideoEntity toEntity() => LocalVideoEntity(
        id: id,
        title: title,
        thumbnailUrl: thumbnailUrl,
        category: category,
        url: '',
        language: '',
        owner: '',
      );

  factory LocalVideoModel.fromEntity(LocalVideoEntity entity) {
    return LocalVideoModel(
        entity.id, entity.title, entity.thumbnailUrl, entity.category);
  }
}
