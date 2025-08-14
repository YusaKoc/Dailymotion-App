import 'package:dailymotion_app/app/features/auth_features/data/usecases/logout_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LogoutStatus { initial, loading, success, error }

class LogoutCubit extends Cubit<LogoutStatus> {
  final LogoutUser logoutUser;
  LogoutCubit(this.logoutUser) : super(LogoutStatus.initial);

  Future<void> logout() async {
    emit(LogoutStatus.loading);
    final result = await logoutUser();
    result.fold(
      (_) => emit(LogoutStatus.error),
      (_) => emit(LogoutStatus.success),
    );
  }
}
