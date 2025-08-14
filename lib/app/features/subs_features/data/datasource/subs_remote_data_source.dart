import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SubscriptionRemoteDataSource {
  Future<void> toggleSubscription(SubscriptionEntity subscription);
  Future<bool> isSubscribed(String channelId);
  Stream<List<SubscriptionEntity>> getSubscriptions();
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SubscriptionRemoteDataSourceImpl(this.firestore, this.auth);

  String get _uid {
    final u = auth.currentUser;
    if (u == null) {
      throw FirebaseAuthException(
        code: 'no-current-user',
        message: 'Oturum bulunamadı',
      );
    }
    return u.uid;
  }

  @override
  Future<void> toggleSubscription(SubscriptionEntity sub) async {
    final docRef = firestore
        .collection('users')
        .doc(_uid)
        .collection('subscriptions')
        .doc(sub.channelId);

    final snapshot = await docRef.get();

    if (snapshot.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'channelId': sub.channelId,
        'screenName': sub.screenName,
        'avatarUrl': sub.avatarUrl,
        'subscribedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<bool> isSubscribed(String channelId) async {
    final doc = await firestore
        .collection('users')
        .doc(_uid)
        .collection('subscriptions')
        .doc(channelId)
        .get();
    return doc.exists;
  }

  @override
  Stream<List<SubscriptionEntity>> getSubscriptions() {
    return firestore
        .collection('users')
        .doc(_uid)
        .collection('subscriptions')
        .orderBy('subscribedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return SubscriptionEntity(
                channelId: data['channelId'],
                screenName: data['screenName'],
                avatarUrl: data['avatarUrl'],
              );
            }).toList());
  }
}
