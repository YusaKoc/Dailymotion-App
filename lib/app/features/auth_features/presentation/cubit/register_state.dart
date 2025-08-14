import 'package:dailymotion_app/app/features/auth_features/data/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterState extends Equatable {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String rePassword;
  final RegisterStatus status;
  final String errorMessage;
  final UserEntity? user;
  final bool obscurePassword;
  final bool obscureRePassword;

  const RegisterState({
    this.name = '',
    this.surname = '',
    this.email = '',
    this.password = '',
    this.rePassword = '',
    this.status = RegisterStatus.initial,
    this.errorMessage = '',
    this.user,
    this.obscurePassword = true,
    this.obscureRePassword = true,
  });

  RegisterState copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? rePassword,
    RegisterStatus? status,
    String? errorMessage,
    UserEntity? user,
    bool? obscurePassword,
    bool? obscureRePassword,
  }) {
    return RegisterState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      rePassword: rePassword ?? this.rePassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureRePassword: obscureRePassword ?? this.obscureRePassword,
    );
  }

  @override
  List<Object?> get props => [
        name,
        surname,
        email,
        password,
        rePassword,
        status,
        errorMessage,
        user,
        obscurePassword,
        obscureRePassword,
      ];
}
