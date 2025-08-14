part of 'subs_cubit.dart';

abstract class SubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionListLoaded extends SubscriptionState {
  final List<SubscriptionEntity> subs;
  final String search;

  SubscriptionListLoaded(this.subs, {this.search = ''});

  @override
  List<Object?> get props => [subs, search];
}

class SubscriptionStatusChanged extends SubscriptionState {
  final String id;
  final bool isSubscribed;

  SubscriptionStatusChanged({required this.id, required this.isSubscribed});

  @override
  List<Object?> get props => [id, isSubscribed];
}
