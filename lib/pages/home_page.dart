// ignore_for_file: prefer_const_constructors

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game/pages/gameplay.dart';
import 'package:game/pages/scoreboard_page.dart';
import 'package:game/quiz_brain.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/home_button.dart';
import 'package:game/constants.dart';

import '../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "homePageId";

  @override
  Widget build(BuildContext context) {
    final brainProvider = Provider.of<Brain>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        brainProvider.onExit(context);
        musicAudioPlayer.pause();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/back.png"), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text('iQUIZ',
                        style: TextStyle(
                          fontSize: 70,
                          color: Colors.white,
                        )),
                  ),
                ),
                Expanded(
                  child: HomeButton(
                    label: "NEW GAME",
                    onPress: () {
                      brainProvider.clickAudioPlayer
                          .play(AssetSource('click.mp3'));
                      Navigator.of(context).pushReplacementNamed(Gameplay.id);
                      brainProvider.startGame();
                    },
                    icon: Icons.play_arrow,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: HomeButton(
                    label: "LOAD GAME",
                    onPress: Provider.of<Brain>(context).isGameStarted
                        ? () {
                            brainProvider.clickAudioPlayer
                                .play(AssetSource('click.mp3'));
                            Navigator.of(context)
                                .pushReplacementNamed(Gameplay.id);
                          }
                        : null,
                    icon: Icons.save,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: HomeButton(
                      label: "SCOREBOARD",
                      onPress: () {
                        brainProvider.saveAndGetScoreboard(States.load);
                        Navigator.of(context).pushNamed(ScoreBoard.id);
                        brainProvider.clickAudioPlayer
                            .play(AssetSource('click.mp3'));
                      },
                      icon: Icons.scoreboard),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: HomeButton(
                      label: "SETTINGS",
                      onPress: () {
                        brainProvider.showSettings(context);
                        brainProvider.clickAudioPlayer
                            .play(AssetSource('click.mp3'));
                      },
                      icon: Icons.settings),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: HomeButton(
                    label: "Exit",
                    icon: Icons.logout,
                    onPress: () {
                      brainProvider.onExit(context);
                      musicAudioPlayer.pause();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
