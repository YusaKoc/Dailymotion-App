import 'package:dailymotion_app/app/common/widgets/bottomnavbar/bottomnavbar_widget.dart';
import 'package:dailymotion_app/app/common/widgets/bottomnavbar/navbar_cubit.dart';
import 'package:dailymotion_app/app/common/widgets/bottomnavbar/navbar_state.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/pages/favorites_page.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/pages/home_page_view.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/pages/search_page_view.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/pages/subs_page_view.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/pages/profile_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorPage extends StatelessWidget {
  const NavigatorPage({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    FavoritesPage(),
    SubscriptionsPage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state.currentIndex],
          bottomNavigationBar: const BottomNavBarWidget(),
        );
      },
    );
  }
}
