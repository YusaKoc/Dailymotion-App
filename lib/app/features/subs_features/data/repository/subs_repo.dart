import 'package:dailymotion_app/app/features/subs_features/data/datasource/subs_remote_data_source.dart';
import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';

abstract class SubscriptionRepository {
  Future<void> toggleSubscription(SubscriptionEntity subscription);
  Future<bool> isSubscribed(String channelId);
  Stream<List<SubscriptionEntity>> getSubscriptions();
}

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remote;

  SubscriptionRepositoryImpl(this.remote);

  @override
  Future<void> toggleSubscription(SubscriptionEntity subscription) {
    return remote.toggleSubscription(subscription);
  }

  @override
  Future<bool> isSubscribed(String channelId) {
    return remote.isSubscribed(channelId);
  }

  @override
  Stream<List<SubscriptionEntity>> getSubscriptions() {
    return remote.getSubscriptions();
  }
}
