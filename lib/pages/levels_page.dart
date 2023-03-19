import 'package:flutter/material.dart';
import 'package:game/models/player.dart';
import 'package:game/pages/home_page.dart';
import 'package:game/providers/audio_provider.dart';
import 'package:game/services/database_helper.dart';
import 'package:game/widgets/choice_button.dart';
import 'package:game/widgets/custom_drawer.dart';
import 'package:game/providers/questions_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LevelsPage extends StatelessWidget {
  const LevelsPage({Key? key}) : super(key: key);
  static String id = "GameplayId";

  void showGameFinishDialog(BuildContext context) {
    final prov = Provider.of<QuestionsProvider>(context, listen: false);
    final scoreController = TextEditingController();
    Alert(
      context: context,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              'Score: ${prov.getScore()}/${prov.getQuestionsLength()}',
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: Colors.white, fontSize: 30),
            textAlign: TextAlign.center,
            controller: scoreController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              labelText: 'Name',
              labelStyle: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (scoreController.text != '' &&
                  scoreController.text.length > 2) {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pushReplacementNamed(HomePage.id);
                DatabaseHelper.insertPlayer(
                    Player(name: scoreController.text, score: prov.getScore()));
              }
            },
            child: const Text('Done', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: const BorderSide(color: Colors.white, width: 3),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
      onWillPopActive: true,
      useRootNavigator: true,
      style: const AlertStyle(
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        isCloseButton: false,
        descStyle: TextStyle(color: Colors.white, fontSize: 40),
      ),
    ).show();
  }

  void showCorrectAnswerDialog(BuildContext context, bool isCorrect) {
    final prov = Provider.of<QuestionsProvider>(context, listen: false);
    Alert(
      context: context,
      type: isCorrect ? AlertType.success : AlertType.error,
      onWillPopActive: true,
      useRootNavigator: true,
      buttons: [
        DialogButton(
          child: const Text(
            "Next Question",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          onPressed: () {
            Navigator.of(context).pop();
            prov.isFinished()
                ? showGameFinishDialog(context)
                : prov.nextQuestion();
          },
        )
      ],
      content: Column(
        children: [
          const Text(
            "Answer",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Text(
            prov.getQuestion().choices[prov.getQuestion().answerNum],
            style: TextStyle(
              color: isCorrect ? Colors.green.shade300 : Colors.red.shade300,
              fontSize: 25,
            ),
          )
        ],
      ),
      style: AlertStyle(
        isCloseButton: false,
        alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: isCorrect ? Colors.green : Colors.red)),
        backgroundColor: Colors.black54,
        descStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title:
              Consumer<QuestionsProvider>(builder: (context, provider, child) {
            return Text(
              'Level ${provider.getQuestionNum() + 1}',
              style: const TextStyle(fontSize: 40),
            );
          }),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
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
                Consumer<QuestionsProvider>(
                    builder: (context, provider, child) {
                  return Text(
                    "Score : ${provider.getScore().toString()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
                Consumer<QuestionsProvider>(
                    builder: (context, provider, child) {
                  return Text(
                    provider.getQuestion().text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  );
                }),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Consumer2<QuestionsProvider, AudioProvider>(builder:
                        (context, questionsProvider, audioProvider, child) {
                      return ChoiceButton(
                        buttonText:
                            questionsProvider.getQuestion().choices[index],
                        onPress: () {
                          bool isCorrect =
                              questionsProvider.isCorrectAnswer(index);
                          isCorrect
                              ? audioProvider.playCorrectAnswerAudio()
                              : audioProvider.playWrongAnswerAudio();
                          showCorrectAnswerDialog(context, isCorrect);
                        },
                      );
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
