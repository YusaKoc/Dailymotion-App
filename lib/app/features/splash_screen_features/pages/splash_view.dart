import 'package:dailymotion_app/app/features/splash_screen_features/widgets/splash_animation.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: SplashAnimation()),
    );
  }
}
