import 'package:dailymotion_app/app/features/auth_features/data/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String? errorMessage;
  final UserEntity? user;
  final bool keepSignedIn;
  final bool obscurePassword;

  const LoginState({
    this.email = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.user,
    this.keepSignedIn = false,
    this.obscurePassword = true,
  });

  LoginState copyWith(
      {String? email,
      String? password,
      LoginStatus? status,
      String? errorMessage,
      UserEntity? user,
      bool? keepSignedIn,
      bool? obscurePassword}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
      user: user ?? this.user,
      keepSignedIn: keepSignedIn ?? this.keepSignedIn,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        errorMessage,
        user,
        keepSignedIn,
        obscurePassword,
      ];
}
