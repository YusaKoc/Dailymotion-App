import 'dart:io';

import 'package:dailymotion_app/app/features/user_profile_features/data/entities/user_profile_entity.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/usecases/profile_usecase.dart';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile getUserProfile;
  final UploadProfilePhoto uploadProfilePhoto;
  final UploadProfilePhotoBytes uploadProfilePhotoBytes;
  final UpdateNameSurname updateNameSurname;

  ProfileCubit(
    this.getUserProfile,
    this.uploadProfilePhoto,
    this.uploadProfilePhotoBytes,
    this.updateNameSurname,
  ) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final res = await getUserProfile();
    res.fold(
      (failure) => emit(ProfileError(failure.message.isNotEmpty
          ? failure.message
          : "Kullanıcı bulunamadı.")),
      (data) => emit(ProfileLoaded(data)),
    );
  }

  Future<void> uploadPhoto(File file) async {
    emit(ProfileLoading());
    final res = await uploadProfilePhoto(file);
    res.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) async => await fetchProfile(),
    );
  }

  Future<void> pickAndUploadPhoto() async {
    emit(ProfileLoading());

    final status = await Permission.storage.request();
    if (!status.isGranted) {
      emit(ProfileError("Galeriye erişim izni verilmedi."));
      return;
    }

    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);
    if (result == null || result.files.single.bytes == null) {
      emit(ProfileError("Dosya seçilmedi."));
      return;
    }

    final bytes = result.files.single.bytes!;
    final res = await uploadProfilePhotoBytes(bytes);
    res.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) async => await fetchProfile(),
    );
  }

  Future<void> updateNameAndSurname(String name, String surname) async {
    emit(ProfileLoading());
    final res = await updateNameSurname(name: name, surname: surname);
    res.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) async => await fetchProfile(),
    );
  }
}
