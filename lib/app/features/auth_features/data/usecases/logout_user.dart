import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/auth_features/data/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUser {
  final AuthRepository repository;
  LogoutUser(this.repository);

  Future<Either<Failure, void>> call() => repository.logout();
}
