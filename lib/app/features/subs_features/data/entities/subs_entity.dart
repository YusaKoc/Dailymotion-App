import 'package:equatable/equatable.dart';

class SubscriptionEntity extends Equatable {
  final String channelId;
  final String screenName;
  final String avatarUrl;

  const SubscriptionEntity({
    required this.channelId,
    required this.screenName,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [channelId, screenName, avatarUrl];
}
