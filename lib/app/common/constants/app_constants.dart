import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Dailymotion";
  static const Duration splashDuration = Duration(seconds: 2);
  static const String errorMessage =
      "Bir hata oluştu internete bağlanıp tekrar deneyin..";
  static const String errorMessageLogin = "Şifreniz ve e-postanız uyuşmuyor..";
}

class AppPadding {
  ///ONLY
  static const EdgeInsets onlyRightSmall = EdgeInsets.only(right: 6);
  static const EdgeInsets onlyRightLarge = EdgeInsets.only(right: 32);
  static const EdgeInsets onlyLeftLarge = EdgeInsets.only(left: 32);
  static const EdgeInsets onlyRight = EdgeInsets.only(right: 12);
  static const EdgeInsets onlyLeft = EdgeInsets.only(left: 12);
  static const EdgeInsets onlyLeftSmall = EdgeInsets.only(left: 6);
  static const EdgeInsets onlyTopSmall = EdgeInsets.only(left: 4);
  static const EdgeInsets onlyBottomLarge = EdgeInsets.only(bottom: 80);
  static const EdgeInsets onlyTop = EdgeInsets.only(top: 12);
  static const EdgeInsets onlyBottom = EdgeInsets.only(bottom: 12);
  static const EdgeInsets onlyTopLarge = EdgeInsets.only(top: 32);
  static const EdgeInsets onlyBottomSmall = EdgeInsets.only(bottom: 6);

  ///ALL
  static const EdgeInsets defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets smallPadding = EdgeInsets.all(8.0);
  static const EdgeInsets largePadding = EdgeInsets.all(32.0);

  ///VERTICAL/HORIZONTAL
  static const EdgeInsets vertical8 = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets vertical16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets vertical24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets vertical32 = EdgeInsets.symmetric(vertical: 32);
  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const EdgeInsets horizontal16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets horizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets horizontal32 = EdgeInsets.symmetric(horizontal: 32);

  ///MİX
  static const EdgeInsets singleChildScrollPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 32);
  static const EdgeInsets buttonPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 14);
  static const EdgeInsets inputPadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const EdgeInsets iconButtonPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  static const EdgeInsets channelHeader =
      EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets channelTitle =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  static const EdgeInsets videoTitle =
      EdgeInsets.symmetric(horizontal: 12, vertical: 10);
}

class AppErrorHandling extends StatelessWidget {
  const AppErrorHandling({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error),
        Text("Bir sorun oluştu.. İnternete bağlanmayı deneyin..")
      ],
    ));
  }
}

class AppErrorHandlingLogin extends StatelessWidget {
  const AppErrorHandlingLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.error), Text("Şifreniz ve e-postanız uyuşmuyor..")],
    ));
  }
}

class AppErrorHandlingChannel extends StatelessWidget {
  const AppErrorHandlingChannel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.error), Text("Kanal bilgisi Alınamadı..")],
    ));
  }
}
