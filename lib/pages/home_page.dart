import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/models/game_state.dart';
import 'package:game/pages/levels_page.dart';
import 'package:game/pages/scoreboard_page.dart';
import 'package:game/providers/audio_provider.dart';
import 'package:game/providers/questions_provider.dart';
import 'package:game/services/database_helper.dart';
import 'package:game/widgets/home_button.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "homePageId";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showExitDialog(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).pauseBGMusic();
    Alert(
      context: context,
      type: AlertType.info,
      onWillPopActive: true,
      useRootNavigator: true,
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20 / MediaQuery.of(context).textScaleFactor),
          ),
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          onPressed: () => SystemNavigator.pop(),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20 / MediaQuery.of(context).textScaleFactor),
          ),
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
            Provider.of<AudioProvider>(context, listen: false).resumeBGMusic();
          },
        )
      ],
      desc: "Exit?",
      style: AlertStyle(
        isCloseButton: false,
        backgroundColor: Colors.black54,
        descStyle: TextStyle(
          color: Colors.white,
          fontSize: 30 / MediaQuery.of(context).textScaleFactor,
        ),
      ),
    ).show();
  }

  void showSettingsDialog(BuildContext context) {
    Alert(
      context: context,
      useRootNavigator: true,
      content: Column(
        children: [
          const Divider(thickness: 2, color: Colors.white),
          ListTile(
            title: Text(
              "BG Music",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
            trailing: Consumer<AudioProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.checkMusicSettings();
                  },
                  icon: Icon(
                    provider.getMusicSettingsIcon(),
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text(
              "SFX",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
            trailing: Consumer<AudioProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.checkSFXSettings();
                  },
                  icon: Icon(
                    provider.getSFXSettingsIcon(),
                    color: Colors.white,
                  ),
                );
              },
            ),
          )
        ],
      ),
      desc: "Settings",
      style: AlertStyle(
        isCloseButton: false,
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        descStyle: TextStyle(
          color: Colors.white,
          fontSize: 30 / MediaQuery.of(context).textScaleFactor,
        ),
      ),
    ).show();
  }

  GameState? _gameState;

  void checkGameState() async {
    final currentGameState = await DatabaseHelper.loadGameState();
    setState(() {
      _gameState = currentGameState;
    });
  }

  @override
  void initState() {
    super.initState();
    checkGameState();
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    return WillPopScope(
      onWillPop: () async {
        showExitDialog(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Text(
                  "iquiz".toUpperCase(),
                  style: TextStyle(
                      fontSize: 70 / scaleFactor, color: Colors.white),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Consumer<QuestionsProvider>(
                      builder: (context, questionsProvider, child) {
                        return HomeButton(
                          onPress: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LevelsPage.id);
                            questionsProvider.startGame();
                          },
                          label: "new game".toUpperCase(),
                          icon: Icons.play_arrow,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Consumer<QuestionsProvider>(
                        builder: (context, questionsProvider, child) {
                      return HomeButton(
                        onPress: _gameState == null
                            ? null
                            : () async {
                                questionsProvider.loadGame(_gameState!);
                                Navigator.of(context)
                                    .pushReplacementNamed(LevelsPage.id);
                              },
                        label: "load game".toUpperCase(),
                        icon: Icons.save_rounded,
                      );
                    }),
                    const SizedBox(height: 20),
                    HomeButton(
                      onPress: () =>
                          Navigator.of(context).pushNamed(ScoreBoardPage.id),
                      label: "scoreboard".toUpperCase(),
                      icon: Icons.scoreboard,
                    ),
                    const SizedBox(height: 20),
                    HomeButton(
                      onPress: () => showSettingsDialog(context),
                      label: "settings".toUpperCase(),
                      icon: Icons.settings,
                    ),
                    const SizedBox(height: 20),
                    HomeButton(
                      onPress: () => showExitDialog(context),
                      label: "exit".toUpperCase(),
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
