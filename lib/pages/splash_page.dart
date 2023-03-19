import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:game/pages/home_page.dart';
import 'package:game/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static String id = "splashScreenId";

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AudioProvider>(context, listen: false).playBGMusic();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: const [
          Text("iQUIZ", style: TextStyle(fontSize: 70, color: Colors.white)),
          SizedBox(height: 100),
          Text("Made by Sherif",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ],
      ),
      duration: 5000,
      splashIconSize: 300,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.blue.shade800,
      nextScreen: const HomePage(),
    );
  }
}
