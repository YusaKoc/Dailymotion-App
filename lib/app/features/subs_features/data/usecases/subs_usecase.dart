import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';
import 'package:dailymotion_app/app/features/subs_features/data/repository/subs_repo.dart';

class ToggleSubscription {
  final SubscriptionRepository repo;
  ToggleSubscription(this.repo);

  Future<void> call(SubscriptionEntity sub) => repo.toggleSubscription(sub);
}

class IsSubscribed {
  final SubscriptionRepository repo;
  IsSubscribed(this.repo);

  Future<bool> call(String id) => repo.isSubscribed(id);
}

class GetSubscriptions {
  final SubscriptionRepository repo;
  GetSubscriptions(this.repo);

  Stream<List<SubscriptionEntity>> call() => repo.getSubscriptions();
}
