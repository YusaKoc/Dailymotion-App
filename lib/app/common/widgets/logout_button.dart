import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/logout_cubit.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_styles.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LogoutDrawerButton extends StatelessWidget {
  const LogoutDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<LogoutCubit>(),
      child: BlocListener<LogoutCubit, LogoutStatus>(
        listener: (context, state) {
          if (state == LogoutStatus.success) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (_) => false,
            );
          } else if (state == LogoutStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Çıkış başarısız.")),
            );
          }
        },
        child: Builder(builder: (context) {
          return ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text('Çıkış Yap', style: AppTextStyles.body(context)),
            onTap: () {
              context.read<LogoutCubit>().logout();
            },
          );
        }),
      ),
    );
  }
}
