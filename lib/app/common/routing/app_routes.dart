import 'package:dailymotion_app/app/features/auth_features/presentation/pages/login_view.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/pages/register_view.dart';
import 'package:dailymotion_app/app/features/channel_detail_features/presentation/pages/channel_video_view.dart';
import 'package:dailymotion_app/app/features/favorites_features/presentation/pages/favorites_page.dart';
import 'package:dailymotion_app/app/features/home_features/data/remote/entities/video_entity.dart';
import 'package:dailymotion_app/app/features/home_features/presentation/pages/home_page_view.dart';
import 'package:dailymotion_app/app/features/navigator_page_features/navigate_screens.dart';
import 'package:dailymotion_app/app/features/search_features/presentation/pages/search_page_view.dart';
import 'package:dailymotion_app/app/features/splash_screen_features/pages/splash_view.dart';
import 'package:dailymotion_app/app/features/subs_features/presentation/pages/subs_page_view.dart';
import 'package:dailymotion_app/app/features/user_profile_features/presentation/pages/profile_page_view.dart';
import 'package:dailymotion_app/app/features/video_detail_features/presentation/pages/video_detail_view.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String videoDetail = '/video-detail';
  static const String channelDetail = '/channel-detail';
  static const String home = '/home';
  static const String favorites = '/favorites';
  static const String subs = '/subs';
  static const String profile = '/profile';
  static const String search = '/search';
  static const String navigator = '/navigator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case channelDetail:
        final args = settings.arguments;
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ChannelDetailPage(channelId: args),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Invalid arguments for channel detail')),
          ),
        );
      case videoDetail:
        final args = settings.arguments;
        if (args is VideoEntity) {
          return MaterialPageRoute(
            builder: (_) => VideoDetailPage(video: args),
          );
        }
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Invalid arguments for video detail')),
          ),
        );

      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case navigator:
        return MaterialPageRoute(builder: (_) => const NavigatorPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case subs:
        return MaterialPageRoute(builder: (_) => const SubscriptionsPage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case search:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
