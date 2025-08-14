import 'package:dailymotion_app/app/features/user_profile_features/data/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel(
      {required super.uid,
      required super.email,
      required super.name,
      required super.photoUrl,
      required super.surname});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
        uid: json['uid'],
        email: json['email'],
        name: json['name'],
        photoUrl: json['photoUrl'],
        surname: json['surname']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'surname': surname
    };
  }
}
