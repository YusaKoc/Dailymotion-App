import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
