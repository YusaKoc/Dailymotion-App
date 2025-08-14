import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String uid;
  final String name;
  final String surname;
  final String email;
  final String photoUrl;

  const UserProfileEntity({
    required this.uid,
    required this.name,
    required this.surname,
    required this.email,
    required this.photoUrl,
  });
  factory UserProfileEntity.fromMap(Map<String, dynamic> map) {
    return UserProfileEntity(
      uid: map['uid'] ?? '',
      name: map['name']?.trim() ?? '',
      surname: map['surname']?.trim() ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'] ??
          'https://firebasestorage.googleapis.com/v0/b/dailymotion-app.firebasestorage.app/o/profile_photos%2Fplaceholder.png?alt=media&token=d93d3fd9-5867-43c6-90ed-831fa98fa0f9',
    );
  }

  @override
  List<Object?> get props => [uid, name, surname, email, photoUrl];
}
