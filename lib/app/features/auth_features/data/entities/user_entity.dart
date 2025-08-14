import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String name;
  final String surname;
  final String email;
  final bool emailVerified;
  final String photoUrl;

  const UserEntity({
    required this.emailVerified,
    required this.uid,
    required this.name,
    required this.surname,
    required this.email,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        surname,
        email,
        photoUrl,
      ];
}
