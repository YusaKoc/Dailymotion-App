import 'package:dailymotion_app/app/common/widgets/logout_button.dart';
import 'package:dailymotion_app/app/features/user_profile_features/data/entities/user_profile_entity.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/cubit/profile_cubit.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralDrawer extends StatelessWidget {
  const GeneralDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          UserProfileEntity? user;
          if (state is ProfileLoaded) user = state.user;

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _DrawerHeader(user: user),
              _DrawerItem(
                icon: Icons.home_outlined,
                text: 'Keşfet',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.home),
              ),
              _DrawerItem(
                icon: Icons.favorite_border,
                text: 'Favori Videolar',
                onTap: () => Navigator.pushReplacementNamed(
                    context, AppRoutes.favorites),
              ),
              _DrawerItem(
                icon: Icons.subscriptions_outlined,
                text: 'Abonelikler',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.subs),
              ),
              _DrawerItem(
                icon: Icons.person_outline,
                text: 'Profil',
                onTap: () =>
                    Navigator.pushReplacementNamed(context, AppRoutes.profile),
              ),
              const Divider(),
              const LogoutDrawerButton(),
            ],
          );
        },
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  final UserProfileEntity? user;

  const _DrawerHeader({this.user});

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: user?.photoUrl.isNotEmpty == true
            ? NetworkImage(user!.photoUrl)
            : const AssetImage('assets/images/placeholder.png')
                as ImageProvider,
      ),
      accountName: Text(user?.name ?? "Yükleniyor..."),
      accountEmail: Text(user?.email ?? ""),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.cyanAccent],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
