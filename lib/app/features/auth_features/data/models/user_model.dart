import 'package:dailymotion_app/app/features/auth_features/data/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.surname,
    required super.email,
    required super.emailVerified,
    required super.photoUrl,
  });

  factory UserModel.fromFirebase(
    UserCredential credential,
    String name,
    String surname,
    String photoUrl,
  ) {
    return UserModel(
      uid: credential.user!.uid,
      name: name,
      surname: surname,
      email: credential.user!.email ?? '',
      emailVerified: credential.user!.emailVerified,
      photoUrl: photoUrl,
    );
  }
}
