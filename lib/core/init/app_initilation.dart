import 'package:dailymotion_app/app/features/home_features/data/local/model_local/local_video_model.dart';
import 'package:dailymotion_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dailymotion_app/app/common/get_it/get_it.dart' as gt;
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Hive
  await Hive.initFlutter();
  final box = await Hive.openBox('settings');

  Hive.registerAdapter(LocalVideoModelAdapter());
  await Hive.openBox<LocalVideoModel>('videos');

  if (!box.containsKey('isDark')) {
    await box.put('isDark', false);
  }

  //portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //firebasae
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //get it
  await gt.init();
}
