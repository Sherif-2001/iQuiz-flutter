// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:game/custom_widgets/choice_button.dart';
import 'package:game/custom_widgets/drawer_button.dart';
import 'package:game/pages/home_page.dart';
import 'package:game/quiz_brain.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Gameplay extends StatelessWidget {
  const Gameplay({Key? key}) : super(key: key);
  static String id = "GameplayId";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        drawer: Container(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text('Menu',
                        style: TextStyle(fontSize: 50, color: Colors.white)),
                  ),
                ),
                DrawerButton(
                    buttonText: "Resume",
                    onPress: () {
                      Navigator.pop(context);
                      Provider.of<Brain>(context, listen: false)
                          .clickAudioPlayer
                          .play(AssetSource('click.mp3'));
                    }),
                SizedBox(height: 30),
                DrawerButton(
                    buttonText: "Settings",
                    onPress: () {
                      Provider.of<Brain>(context, listen: false)
                          .showSettings(context);
                      Provider.of<Brain>(context, listen: false)
                          .clickAudioPlayer
                          .play(AssetSource('click.mp3'));
                    }),
                SizedBox(height: 30),
                DrawerButton(
                  buttonText: "Home",
                  onPress: () {
                    Navigator.of(context).pushReplacementNamed(HomePage.id);
                    Provider.of<Brain>(context, listen: false)
                        .clickAudioPlayer
                        .play(AssetSource('click.mp3'));
                  },
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
                'Level ${Provider.of<Brain>(context).getQuestionNum() + 1}',
                style: TextStyle(fontSize: 40)),
            centerTitle: true,
            foregroundColor: Colors.white),
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
                  flex: 2,
                  child: Center(
                    child: Text(
                        "Score : ${Provider.of<Brain>(context).getScoreValue().toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(Provider.of<Brain>(context).getQuestionText(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: ChoiceButton(
                    buttonText: Provider.of<Brain>(context).getChoicesText(1),
                    onPress: () {
                      if (Provider.of<Brain>(context, listen: false)
                          .checkAnswer(1)) {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.success, true);
                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .stop();

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("correct.mp3"));
                      } else {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.error, false);
                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .stop();

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("wrong.mp3"));
                      }

                      Provider.of<Brain>(context, listen: false)
                          .clickAudioPlayer
                          .play(AssetSource("click.mp3"));
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ChoiceButton(
                    buttonText: Provider.of<Brain>(context).getChoicesText(2),
                    onPress: () {
                      if (Provider.of<Brain>(context, listen: false)
                          .checkAnswer(2)) {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.success, true);

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("correct.mp3"));
                      } else {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.error, false);

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("wrong.mp3"));
                      }

                      Provider.of<Brain>(context, listen: false)
                          .clickAudioPlayer
                          .play(AssetSource("click.mp3"));
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ChoiceButton(
                    buttonText: Provider.of<Brain>(context).getChoicesText(3),
                    onPress: () {
                      if (Provider.of<Brain>(context, listen: false)
                          .checkAnswer(3)) {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.success, true);

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("correct.mp3"));
                      } else {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.error, false);

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("wrong.mp3"));
                      }

                      Provider.of<Brain>(context, listen: false)
                          .clickAudioPlayer
                          .play(AssetSource("click.mp3"));
                    },
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ChoiceButton(
                    buttonText: Provider.of<Brain>(context).getChoicesText(4),
                    onPress: () {
                      if (Provider.of<Brain>(context, listen: false)
                          .checkAnswer(4)) {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.success, true);

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("correct.mp3"));
                      } else {
                        Provider.of<Brain>(context, listen: false)
                            .onChoice(context, AlertType.error, false);

                        Provider.of<Brain>(context, listen: false)
                            .answerAudioPlayer
                            .play(AssetSource("wrong.mp3"));
                      }

                      Provider.of<Brain>(context, listen: false)
                          .clickAudioPlayer
                          .play(AssetSource("click.mp3"));
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
