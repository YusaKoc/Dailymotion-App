import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_state.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/widgets/is_registered_button.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/widgets/login_form.dart';
import 'package:dailymotion_app/app/features/navigator_page_features/navigate_screens.dart';

import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              if (state.user != null && state.user!.emailVerified == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const NavigatorPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Lütfen e-posta adresinizi doğrulayın.")),
                );
              }
            } else if (state.status == LoginStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage ?? "Giriş başarısız.")),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                padding: AppPadding.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: AppTextStyles.heading1Bold(context),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Hoş Geldiniz",
                      style: AppTextStyles.heading1(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Devam etmek için giriş yapın",
                      style: AppTextStyles.heading2(context),
                    ),
                    const SizedBox(height: 32),
                    const LoginForm(),
                    const SizedBox(height: 16),
                    const IsRegistered(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
