import 'package:dailymotion_app/app/common/theme/app_styles/app_input_styles.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingForm extends StatelessWidget {
  const SettingForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.surnameController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController surnameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: AppInputStyles.inputDecoration(context,
                hint: 'Ad', icon: Icons.person),
            validator: (val) =>
                val == null || val.trim().isEmpty ? 'Ad boş olamaz' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: surnameController,
            decoration: AppInputStyles.inputDecoration(context,
                hint: 'Soyad', icon: Icons.person),
            validator: (val) =>
                val == null || val.trim().isEmpty ? 'Soyad boş olamaz' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final name = nameController.text.trim();
                final surname = surnameController.text.trim();
                context
                    .read<ProfileCubit>()
                    .updateNameAndSurname(name, surname);
              }
            },
            child: const Text("Güncelle"),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
