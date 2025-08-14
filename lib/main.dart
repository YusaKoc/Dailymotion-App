import 'package:dailymotion_app/app/common/theme/app_theme.dart';
import 'package:dailymotion_app/app/common/theme/theme_cubit.dart';
import 'package:dailymotion_app/app/common/widgets/bottomnavbar/navbar_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/login_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/register_cubit.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/cubit/channel_video_cubit.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/cubit/favorite_cubit.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/pages/favorites_page.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/cubit/video_cubit.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/cubit/search_cubit.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/cubit/subs_cubit.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/cubit/profile_cubit.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/cubit/channel_cubit.dart';
import 'package:dailymotion_app/core/init/app_initilation.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:dailymotion_app/app/common/routing/route_observer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dailymotion_app/app/common/get_it/get_it.dart' as gt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(Typography.blackCupertino);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => gt.sl<RegisterCubit>()),
        BlocProvider(create: (_) => gt.sl<LoginCubit>()),
        BlocProvider(create: (_) => gt.sl<VideoCubit>()),
        BlocProvider(create: (_) => gt.sl<ChannelVideosCubit>()),
        BlocProvider(create: (_) => gt.sl<ChannelCubit>()),
        BlocProvider(
          create: (_) => gt.sl<FavoriteCubit>()..loadFavoritesOnce(),
          child: const FavoritesPage(),
        ),
        BlocProvider(create: (_) => gt.sl<SubscriptionCubit>()..watchAll()),
        BlocProvider(create: (_) => gt.sl<ProfileCubit>()),
        BlocProvider(create: (_) => gt.sl<NavigationCubit>()),
        BlocProvider(create: (_) => gt.sl<ThemeCubit>()),
        BlocProvider(create: (_) => gt.sl<SearchCubit>()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          navigatorObservers: [routeObserver],
          title: 'Dailymotion',
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          themeMode: context.watch<ThemeCubit>().state,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: AppRoutes.splash,
        );
      }),
    );
  }
}
