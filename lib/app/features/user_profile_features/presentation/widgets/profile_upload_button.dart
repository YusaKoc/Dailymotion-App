import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/cubit/profile_cubit.dart';

class ProfileUploadButton extends StatelessWidget {
  const ProfileUploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<ProfileCubit>().pickAndUploadPhoto();
      },
      icon: const Icon(Icons.upload),
      label: const Text("Fotoğraf Yükle"),
      style: ElevatedButton.styleFrom(
        padding: AppPadding.buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
