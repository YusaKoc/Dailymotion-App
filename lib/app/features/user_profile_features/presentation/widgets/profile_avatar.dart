import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String photoUrl;

  const ProfileAvatar({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: photoUrl.isNotEmpty
          ? NetworkImage(photoUrl)
          : const AssetImage('assets/images/placeholder.png') as ImageProvider,
    );
  }
}
