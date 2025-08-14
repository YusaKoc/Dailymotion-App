import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/auth_features/data/entities/user_entity.dart';
import 'package:dailymotion_app/app/features/auth_features/data/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUser {
  final AuthRepository repository;
  RegisterUser(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String surname,
    required String email,
    required String password,
    String? photoUrl,
  }) {
    return repository.registerUser(
      name: name,
      surname: surname,
      email: email,
      password: password,
      photoUrl: photoUrl,
    );
  }
}
