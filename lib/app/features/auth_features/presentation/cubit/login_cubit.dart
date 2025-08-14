import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/auth_features/data/usecases/login_user.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_state.dart';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;

  LoginCubit(this.loginUser) : super(const LoginState());

  void toggleKeepSignedIn(bool value) {
    emit(state.copyWith(keepSignedIn: value));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(
      obscurePassword: !state.obscurePassword,
      status: LoginStatus.initial,
    ));
  }

  void updateField({String? email, String? password}) {
    emit(state.copyWith(
      email: email ?? state.email,
      password: password ?? state.password,
      errorMessage: null,
      status: LoginStatus.initial,
    ));
  }

  Future<void> login() async {
    emit(state.copyWith(status: LoginStatus.loading));

    final result = await loginUser(
      email: state.email,
      password: state.password,
    );

    result.fold((failure) {
      final message = switch (failure) {
        NetworkFailure _ => AppConstants.errorMessage,
        AuthFailure _ => AppConstants.errorMessageLogin,
        ServerFailure _ => AppConstants.errorMessage,
        UnknownFailure _ => AppConstants.errorMessage,
        _ => AppConstants.errorMessage,
      };

      emit(state.copyWith(
        status: LoginStatus.error,
        errorMessage: message,
      ));
    }, (user) async {
      final box = Hive.box('settings');
      if (state.keepSignedIn) {
        await box.put('keepSignedIn', true);
        await box.put('uid', user.uid);
      } else {
        await box.put('keepSignedIn', false);
        await box.delete('uid');
      }

      emit(state.copyWith(status: LoginStatus.success, user: user));
    });
  }
}
