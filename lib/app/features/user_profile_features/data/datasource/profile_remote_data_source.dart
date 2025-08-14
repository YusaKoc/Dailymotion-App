import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/model/user_profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getProfile();
  Future<void> uploadProfilePhoto(File file);
  Future<void> uploadProfilePhotoBytes(Uint8List bytes);
  Future<void> updateNameSurname(
      {required String name, required String surname});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  ProfileRemoteDataSourceImpl(this.firestore, this.auth, this.storage);

  @override
  Future<UserProfileModel> getProfile() async {
    final uid = auth.currentUser!.uid;
    final doc = await firestore.collection('users').doc(uid).get();
    return UserProfileModel.fromJson(doc.data()!);
  }

  @override
  Future<void> uploadProfilePhoto(File file) async {
    final uid = auth.currentUser!.uid;
    final ref = storage.ref().child('profile_photos/$uid.jpg');
    final task = await ref.putFile(file);
    final url = await task.ref.getDownloadURL();
    await firestore.collection('users').doc(uid).update({'photoUrl': url});
  }

  @override
  Future<void> uploadProfilePhotoBytes(Uint8List bytes) async {
    final uid = auth.currentUser!.uid;
    final ref = storage.ref().child('profile_photos/$uid.jpg');
    final task = await ref.putData(bytes);
    final url = await task.ref.getDownloadURL();
    await firestore.collection('users').doc(uid).update({'photoUrl': url});
  }

  @override
  Future<void> updateNameSurname(
      {required String name, required String surname}) async {
    final uid = auth.currentUser!.uid;
    await firestore
        .collection('users')
        .doc(uid)
        .update({'name': name, 'surname': surname});
  }
}
