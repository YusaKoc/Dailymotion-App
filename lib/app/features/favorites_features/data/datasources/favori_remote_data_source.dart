import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailymotion_app/app/features/favorites_features/data/entities/favorites_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FavoriteRemoteDataSource {
  Future<void> toggleFavorite(FavoriteEntity favorite);
  Future<bool> isFavorite(String videoId);
  Future<List<FavoriteEntity>> getFavorites();
  Stream<List<FavoriteEntity>> getFavoritesStream();
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoriteRemoteDataSourceImpl(this.firestore, this.auth);

  String get _uid {
    final user = auth.currentUser;
    if (user == null) throw Exception("Kullanıcı oturum açmamış.");
    return user.uid;
  }

  @override
  Future<void> toggleFavorite(FavoriteEntity favorite) async {
    final ref = firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(favorite.videoId);

    final snapshot = await ref.get();

    if (snapshot.exists) {
      await ref.delete();
    } else {
      await ref.set({
        'videoId': favorite.videoId,
        'title': favorite.title,
        'thumbnailUrl': favorite.thumbnailUrl,
        'videoUrl': favorite.videoUrl,
        'addedAt': FieldValue.serverTimestamp(),
        'owner': favorite.owner,
      });
    }
  }

  @override
  Future<bool> isFavorite(String videoId) async {
    final doc = await firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .doc(videoId)
        .get();
    return doc.exists;
  }

  @override
  Future<List<FavoriteEntity>> getFavorites() async {
    final snapshot = await firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .orderBy('addedAt', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return FavoriteEntity(
        videoId: data['videoId'],
        title: data['title'],
        thumbnailUrl: data['thumbnailUrl'],
        videoUrl: data['videoUrl'],
        owner: data['owner'] ?? '',
      );
    }).toList();
  }

  @override
  Stream<List<FavoriteEntity>> getFavoritesStream() {
    return firestore
        .collection('users')
        .doc(_uid)
        .collection('favorites')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return FavoriteEntity(
                  videoId: data['videoId'],
                  title: data['title'],
                  thumbnailUrl: data['thumbnailUrl'],
                  videoUrl: data['videoUrl'],
                  owner: data['owner']);
            }).toList());
  }
}
