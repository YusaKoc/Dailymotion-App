import 'dart:async';
import 'package:dailymotion_app/app/features/subs_features/data/entities/subs_entity.dart';
import 'package:dailymotion_app/app/features/subs_features/data/usecases/subs_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subs_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final ToggleSubscription toggleSub;
  final IsSubscribed isSub;
  final GetSubscriptions getSubs;

  final Map<String, bool> _channelSubs = {};
  Timer? _debounce;

  List<SubscriptionEntity> _allSubs = [];
  String _search = '';

  SubscriptionCubit(this.toggleSub, this.isSub, this.getSubs)
      : super(SubscriptionInitial());

  StreamSubscription<List<SubscriptionEntity>>? _subsStream;

  void watchAll() {
    emit(SubscriptionLoading());

    _subsStream?.cancel();
    _subsStream = getSubs().listen(
      (subs) {
        _allSubs = subs;
        final filtered = _filter(_allSubs, _search);
        emit(SubscriptionListLoaded(filtered, search: _search));
      },
      onError: (error) {
        emit(SubscriptionInitial());
      },
    );
  }

  List<SubscriptionEntity> _filter(List<SubscriptionEntity> src, String q) {
    if (q.isEmpty) return src;
    final lower = q.toLowerCase();
    return src
        .where((s) => s.screenName.toLowerCase().contains(lower))
        .toList();
  }

  void updateSearch(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search = value;
      final filtered = _filter(_allSubs, _search);
      emit(SubscriptionListLoaded(filtered, search: _search));
    });
  }

  Future<void> toggle(SubscriptionEntity sub) async {
    await toggleSub(sub);
    await check(sub.channelId);
  }

  Future<void> check(String id) async {
    final result = await isSub(id);
    _channelSubs[id] = result;
    emit(SubscriptionStatusChanged(id: id, isSubscribed: result));
  }

  bool isSubscribed(String id) => _channelSubs[id] ?? false;

  @override
  Future<void> close() async {
    _subsStream?.cancel();
    _debounce?.cancel();
    return super.close();
  }
}
