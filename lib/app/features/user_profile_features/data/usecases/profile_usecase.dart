import 'dart:io';
import 'dart:typed_data';

import 'package:dailymotion_app/app/common/try_catch/failure.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/entities/user_profile_entity.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/repository/profile_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserProfile {
  final ProfileRepository repo;
  GetUserProfile(this.repo);
  Future<Either<Failure, UserProfileEntity>> call() => repo.getProfile();
}

class UploadProfilePhoto {
  final ProfileRepository repo;
  UploadProfilePhoto(this.repo);
  Future<Either<Failure, void>> call(File file) =>
      repo.uploadProfilePhoto(file);
}

class UploadProfilePhotoBytes {
  final ProfileRepository repo;
  UploadProfilePhotoBytes(this.repo);
  Future<Either<Failure, void>> call(Uint8List bytes) =>
      repo.uploadProfilePhotoBytes(bytes);
}

class UpdateNameSurname {
  final ProfileRepository repo;
  UpdateNameSurname(this.repo);
  Future<Either<Failure, void>> call(
          {required String name, required String surname}) =>
      repo.updateNameSurname(name: name, surname: surname);
}
