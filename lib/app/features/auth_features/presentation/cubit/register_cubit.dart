import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/auth_features/data/usecases/register_user.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUser registerUser;
  RegisterCubit(this.registerUser) : super(const RegisterState());

  Future<void> register() async {
    if (state.password != state.rePassword) {
      emit(state.copyWith(
        status: RegisterStatus.error,
        errorMessage: "Şifreler uyuşmuyor",
      ));
      return;
    }
    if (state.password.length < 6) {
      emit(state.copyWith(
        status: RegisterStatus.error,
        errorMessage: "Şifre en az 6 karakter olmalı",
      ));
      return;
    }

    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await registerUser(
      name: state.name,
      surname: state.surname,
      email: state.email,
      password: state.password,
    );

    result.fold((failure) {
      final message = switch (failure) {
        NetworkFailure _ => AppConstants.errorMessage,
        AuthFailure _ => failure.message.isNotEmpty
            ? failure.message
            : AppConstants.errorMessageLogin,
        ServerFailure _ => AppConstants.errorMessage,
        UnknownFailure _ => AppConstants.errorMessage,
        _ => AppConstants.errorMessage,
      };

      emit(state.copyWith(
        status: RegisterStatus.error,
        errorMessage: message,
      ));
    }, (user) {
      emit(state.copyWith(
        status: RegisterStatus.success,
        user: user,
        errorMessage:
            "Kayıt başarılı! E‑posta adresine doğrulama bağlantısı gönderildi.",
      ));
    });
  }

  void updateField({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? rePassword,
  }) {
    emit(state.copyWith(
      name: name ?? state.name,
      surname: surname ?? state.surname,
      email: email ?? state.email,
      password: password ?? state.password,
      rePassword: rePassword ?? state.rePassword,
      status: RegisterStatus.initial,
      errorMessage: '',
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void toggleRePasswordVisibility() {
    emit(state.copyWith(obscureRePassword: !state.obscureRePassword));
  }
}
