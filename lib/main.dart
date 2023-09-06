import 'package:iquiz_flutter/pages/levels_page.dart';
import 'package:iquiz_flutter/pages/scoreboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iquiz_flutter/pages/splash_page.dart';
import 'package:iquiz_flutter/providers/audio_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'providers/questions_provider.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuestionsProvider()),
        ChangeNotifierProvider(create: (context) => AudioProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: "fredokaOne"),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.id,
        routes: {
          SplashPage.id: (context) => const SplashPage(),
          HomePage.id: (context) => const HomePage(),
          LevelsPage.id: (context) => const LevelsPage(),
          ScoreBoardPage.id: (context) => const ScoreBoardPage()
        },
      ),
    );
  }
}
