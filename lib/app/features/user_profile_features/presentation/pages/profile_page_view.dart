import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/theme_cubit.dart';
import 'package:dailymotion_app/app/common/widgets/logout_button.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/cubit/profile_cubit.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/widgets/profile_avatar.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/widgets/profile_info.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/widgets/profile_settings.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/widgets/profile_theme_switch.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/widgets/profile_upload_button.dart';

import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: AppTextStyles.heading1Bold(context),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ));
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.navigator,
                (route) => false,
              );
            });
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final nameController = TextEditingController(text: state.user.name);
            final surnameController =
                TextEditingController(text: state.user.surname);

            return SingleChildScrollView(
              padding: AppPadding.singleChildScrollPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: ProfileAvatar(photoUrl: state.user.photoUrl)),
                  const SizedBox(height: 24),
                  Center(
                    child: ProfileInfo(
                      name: state.user.name,
                      email: state.user.email,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Divider(height: 48),
                  Text(
                    "Ayarlar",
                    style: AppTextStyles.heading2(context),
                  ),
                  const SizedBox(height: 32),
                  SettingForm(
                      formKey: _formKey,
                      nameController: nameController,
                      surnameController: surnameController),
                  const Center(child: ProfileUploadButton()),
                  const SizedBox(height: 32),
                  ProfileThemeSwitch(
                    isDark: context.watch<ThemeCubit>().state == ThemeMode.dark,
                    onToggle: () => context.read<ThemeCubit>().toggleTheme(),
                  ),
                  const SizedBox(height: 32),
                  const LogoutDrawerButton()
                ],
              ),
            );
          } else if (state is ProfileError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.navigator,
                (route) => false,
              );
            });
            return const SizedBox();
          }
          return const Center(child: Text("Yükleniyor..."));
        },
      ),
    );
  }
}
