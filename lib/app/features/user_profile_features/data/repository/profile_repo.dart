import 'dart:io';
import 'dart:typed_data';

import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/core/utils/network_info.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/datasource/profile_remote_data_source.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/entities/user_profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfileEntity>> getProfile();
  Future<Either<Failure, void>> uploadProfilePhoto(File file);
  Future<Either<Failure, void>> uploadProfilePhotoBytes(Uint8List bytes);
  Future<Either<Failure, void>> updateNameSurname(
      {required String name, required String surname});
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;
  final NetworkInfo networkInfo;
  ProfileRepositoryImpl(this.remote, this.networkInfo);

  @override
  Future<Either<Failure, UserProfileEntity>> getProfile() async {
    try {
      final res = await remote.getProfile();
      return Right(res);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> uploadProfilePhoto(File file) async {
    try {
      if (!await networkInfo.isConnected)
        return const Left(NetworkFailure("İnternet yok."));
      await remote.uploadProfilePhoto(file);
      return const Right(null);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> uploadProfilePhotoBytes(Uint8List bytes) async {
    try {
      if (!await networkInfo.isConnected)
        return const Left(NetworkFailure("İnternet yok."));
      await remote.uploadProfilePhotoBytes(bytes);
      return const Right(null);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNameSurname(
      {required String name, required String surname}) async {
    try {
      if (!await networkInfo.isConnected)
        return const Left(NetworkFailure("İnternet yok."));
      await remote.updateNameSurname(name: name, surname: surname);
      return const Right(null);
    } on FirebaseAuthException {
      return const Left(ServerFailure("Oturum bulunamadı."));
    } on FirebaseException {
      return const Left(ServerFailure());
    } catch (_) {
      return const Left(UnknownFailure());
    }
  }
}
