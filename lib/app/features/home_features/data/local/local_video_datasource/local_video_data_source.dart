import 'package:dailymotion_app/app/features/home_features/data/local/entities_local/local_video_entitiy.dart';
import 'package:dailymotion_app/app/features/home_features/data/local/model_local/local_video_model.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class VideoLocalDataSource {
  Future<void> cacheVideos(String category, List<VideoEntity> videos);
  Future<List<VideoEntity>> getCachedVideos(String category);
}

class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  final Box<LocalVideoModel> box;

  VideoLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheVideos(String category, List<VideoEntity> videos) async {
    final toDelete = box.values
        .where((e) => e.category == category)
        .map((e) => e.key)
        .toList();
    await box.deleteAll(toDelete);

    final newModels = videos
        .take(20)
        .map((e) => LocalVideoModel.fromEntity(LocalVideoEntity(
              id: e.id,
              title: e.title,
              thumbnailUrl: e.thumbnailUrl,
              category: category,
            )))
        .toList();

    for (final model in newModels) {
      await box.add(model);
    }
  }

  @override
  Future<List<VideoEntity>> getCachedVideos(String category) async {
    final cached = box.values
        .where((e) => e.category == category)
        .map((e) => e.toEntity())
        .toList();
    return cached;
  }
}
