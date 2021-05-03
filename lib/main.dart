import 'package:dino_run/game/audio_manager.dart';
import 'package:dino_run/screens/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await AudioManager.instance
      .init(['8Bit Platformer Loop.wav', 'hurt7.wav', 'jump14.wav']);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Run',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainMenu(),
    );
  }
}
