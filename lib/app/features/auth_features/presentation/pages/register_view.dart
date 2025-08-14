import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/register_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/widgets/is_already_registered.dart';
import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/register_form.dart';
import 'package:dailymotion_app/app/common/get_it/get_it.dart' as gt;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (_) => gt.sl<RegisterCubit>(),
          child: Center(
            child: SingleChildScrollView(
              padding: AppPadding.defaultPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.appName,
                    style: AppTextStyles.heading1Bold(context),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Hesap Oluştur",
                    style: AppTextStyles.heading1(context),
                  ),
                  const SizedBox(height: 8),
                  Text("Dailymotion’a kaydolun",
                      style: AppTextStyles.heading2(context)),
                  const SizedBox(height: 32),
                  const RegisterForm(),
                  const SizedBox(height: 16),
                  const IsAlreadyRegistered(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
