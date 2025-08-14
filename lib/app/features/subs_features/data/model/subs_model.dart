import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';

class SubscriptionModel extends SubscriptionEntity {
  const SubscriptionModel({
    required super.channelId,
    required super.screenName,
    required super.avatarUrl,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      channelId: json['channelId'],
      screenName: json['screenName'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'screenName': screenName,
      'avatarUrl': avatarUrl,
    };
  }
}
