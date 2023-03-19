import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/pages/levels_page.dart';
import 'package:game/pages/scoreboard_page.dart';
import 'package:game/providers/audio_provider.dart';
import 'package:game/providers/questions_provider.dart';
import 'package:game/widgets/home_button.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "homePageId";

  void showExitDialog(BuildContext context) {
    Provider.of<AudioProvider>(context, listen: false).pauseBGMusic();
    Alert(
            context: context,
            type: AlertType.info,
            onWillPopActive: true,
            useRootNavigator: true,
            buttons: [
              DialogButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                border: Border.all(color: Colors.white, width: 2),
                color: Colors.transparent,
                onPressed: () => SystemNavigator.pop(),
              ),
              DialogButton(
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                border: Border.all(color: Colors.white, width: 2),
                color: Colors.transparent,
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<AudioProvider>(context, listen: false)
                      .resumeBGMusic();
                },
              )
            ],
            desc: "Exit??",
            style: const AlertStyle(
                isCloseButton: false,
                backgroundColor: Colors.black54,
                descStyle: TextStyle(color: Colors.white, fontSize: 30)))
        .show();
  }

  void showSettingsDialog(BuildContext context) {
    Alert(
            context: context,
            useRootNavigator: true,
            content: Column(
              children: [
                const Divider(thickness: 2, color: Colors.white),
                ListTile(
                  title: const Text(
                    "BG Music",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
                  title: const Text(
                    "SFX",
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
            style: const AlertStyle(
                isCloseButton: false,
                isButtonVisible: false,
                backgroundColor: Colors.black54,
                descStyle: TextStyle(color: Colors.white, fontSize: 30)))
        .show();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionsProvider>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            showExitDialog(context);
            return false;
          },
          child: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'iQUIZ',
                      style: TextStyle(fontSize: 70, color: Colors.white),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HomeButton(
                          onPress: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LevelsPage.id);
                            provider.startGame();
                          },
                          label: "NEW GAME",
                          icon: Icons.play_arrow,
                        ),
                        const SizedBox(height: 20),
                        HomeButton(
                            onPress: () {
                              Navigator.of(context)
                                  .pushNamed(ScoreBoardPage.id);
                            },
                            label: "SCOREBOARD",
                            icon: Icons.scoreboard),
                        const SizedBox(height: 20),
                        HomeButton(
                            onPress: () => showSettingsDialog(context),
                            label: "SETTINGS",
                            icon: Icons.settings),
                        const SizedBox(height: 20),
                        HomeButton(
                          onPress: () => showExitDialog(context),
                          label: "EXIT",
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
      },
    );
  }
}
