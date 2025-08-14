import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_state.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_button_styles.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_input_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
        TextField(
          decoration: AppInputStyles.inputDecoration(
            context,
            hint: "E-posta adresinizi girin",
            icon: Icons.email_outlined,
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => cubit.updateField(email: value),
        ),
        const SizedBox(height: 16),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.obscurePassword != current.obscurePassword ||
              previous.password != current.password,
          builder: (context, state) {
            return TextField(
              decoration: AppInputStyles.inputDecoration(
                context,
                hint: "Şifrenizi girin",
                icon: Icons.lock_outline,
              ).copyWith(
                suffixIcon: IconButton(
                  icon: Icon(state.obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () =>
                      context.read<LoginCubit>().togglePasswordVisibility(),
                ),
              ),
              obscureText: state.obscurePassword,
              onChanged: (value) => cubit.updateField(password: value),
            );
          },
        ),
        const SizedBox(height: 8),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (p, c) => p.keepSignedIn != c.keepSignedIn,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: state.keepSignedIn,
                  onChanged: (val) => cubit.toggleKeepSignedIn(val ?? false),
                ),
                const Text("Beni hatırla"),
                const Spacer(),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: state.status == LoginStatus.loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: AppButtonStyles.primary,
                      onPressed: cubit.login,
                      child: const Text("Giriş Yap"),
                    ),
            );
          },
        ),
      ],
    );
  }
}
