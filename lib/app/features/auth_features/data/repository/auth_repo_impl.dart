import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dailymotion_app/app/features/auth_features/data/datasources/auth_remote_data_source.dart';
import 'package:dailymotion_app/app/features/auth_features/data/entities/user_entity.dart';
import 'package:dailymotion_app/app/features/auth_features/data/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/adapters.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FirebaseAuth firebaseAuth;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.firebaseAuth,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required String name,
    required String surname,
    required String email,
    required String password,
    String? photoUrl,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }
      final user = await remoteDataSource.registerUser(
        name: name,
        surname: surname,
        email: email,
        password: password,
        photoUrl: photoUrl,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapFirebaseAuthCode(e.code)));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        return const Left(NetworkFailure());
      }
      final user = await remoteDataSource.loginWithEmail(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapFirebaseAuthCode(e.code)));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      if (!await networkInfo.isConnected) {}
      await firebaseAuth.signOut();
      final box = Hive.box('settings');
      await box.clear();
      return const Right(null);
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  String _mapFirebaseAuthCode(String code) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return "E-posta veya şifre hatalı.";
      case 'user-disabled':
        return "Hesabınız devre dışı.";
      case 'too-many-requests':
        return "Çok fazla deneme yapıldı, lütfen sonra deneyin.";
      default:
        return "Kimlik doğrulama hatası.";
    }
  }
}
