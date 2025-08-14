import 'package:dailymotion_app/app/common/constants/app_assets.dart';
import 'package:dailymotion_app/app/common/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkKeepSignedIn();
      }
    });
  }

  Future<void> _checkKeepSignedIn() async {
    final box = Hive.box('settings');
    final keepSignedIn = box.get('keepSignedIn', defaultValue: false);
    final uid = box.get('uid');

    if (keepSignedIn == true && uid != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.navigator);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AppAssets.Splash,
        width: context.sized.dynamicWidth(0.8),
        height: context.sized.dynamicHeight(0.5),
        controller: _controller,
        onLoaded: (composition) {
          _controller.duration = composition.duration;
          _controller.forward();
        },
      ),
    );
  }
}
