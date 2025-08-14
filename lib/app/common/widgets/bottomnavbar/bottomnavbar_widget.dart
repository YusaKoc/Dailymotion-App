import 'package:dailymotion_app/app/common/widgets/bottomnavbar/navbar_cubit.dart';
import 'package:dailymotion_app/app/common/widgets/bottomnavbar/navbar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  void _onItemTapped(BuildContext context, int index) {
    context.read<NavigationCubit>().changeTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (index) => _onItemTapped(context, index),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favoriler'),
            BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions), label: 'Abonelikler'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Ara'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        );
      },
    );
  }
}
