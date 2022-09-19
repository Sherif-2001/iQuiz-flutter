// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:game/constants.dart';
import 'package:game/notification_service.dart';
import 'package:game/pages/gameplay.dart';
import 'package:game/pages/scoreboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'quiz_brain.dart';

final musicAudioPlayer = AudioPlayer();
Brain brain = Brain();
void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    musicAudioPlayer.setReleaseMode(ReleaseMode.loop);
    musicAudioPlayer.play(AssetSource('music.mp3'), volume: 0.5);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      notificationServices.initializeNotifications();
      notificationServices.sendNotification(
          "🔔See you soon🔔", "Hope you had fun playing our game, 😊");
      musicAudioPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Brain(),
      child: MaterialApp(
        theme: ThemeData(fontFamily: "fredokaOne"),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          HomePage.id: (context) => HomePage(),
          Gameplay.id: (context) => Gameplay(),
          ScoreBoard.id: (context) => ScoreBoard()
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String id = "splashScreenId";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<Brain>(context, listen: false).saveAndLoadGame(States.load);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Text("iQUIZ", style: TextStyle(fontSize: 70, color: Colors.white)),
          SizedBox(height: 100),
          Text("Made by Sherif",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
      duration: 5000,
      splashIconSize: 300,
      animationDuration: Duration(seconds: 1),
      backgroundColor: Colors.blue.shade800,
      nextScreen: HomePage(),
    );
  }
}
