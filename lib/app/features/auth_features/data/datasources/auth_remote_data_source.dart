import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dailymotion_app/app/common/constants/app_assets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail(String email, String password);

  Future<UserModel> registerUser({
    required String name,
    required String surname,
    required String email,
    required String password,
    String? photoUrl,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> registerUser({
    required String name,
    required String surname,
    required String email,
    required String password,
    String? photoUrl,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'photoUrl': photoUrl ?? AppAssets.placeholder,
      'created_at': FieldValue.serverTimestamp(),
    });

    await credential.user!.sendEmailVerification();

    return UserModel.fromFirebase(
      credential,
      name,
      surname,
      photoUrl ?? AppAssets.placeholder,
    );
  }

  @override
  Future<UserModel> loginWithEmail(String email, String password) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    final snapshot = await firestore.collection('users').doc(uid).get();
    final data = snapshot.data();

    return UserModel(
      uid: uid,
      name: data?['name'] ?? '',
      surname: data?['surname'] ?? '',
      email: credential.user!.email ?? '',
      emailVerified: credential.user!.emailVerified,
      photoUrl: data?['photoUrl'] ?? AppAssets.placeholder,
    );
  }
}
