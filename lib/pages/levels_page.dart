import 'package:flutter/material.dart';
import 'package:iquiz_flutter/models/player.dart';
import 'package:iquiz_flutter/pages/home_page.dart';
import 'package:iquiz_flutter/providers/audio_provider.dart';
import 'package:iquiz_flutter/services/database_helper.dart';
import 'package:iquiz_flutter/widgets/choice_button.dart';
import 'package:iquiz_flutter/widgets/custom_drawer.dart';
import 'package:iquiz_flutter/providers/questions_provider.dart';
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
              'Score: ${prov.currentScore}/${prov.questionsLength}',
              style: TextStyle(
                  fontSize: 30 / MediaQuery.of(context).textScaleFactor,
                  color: Colors.white),
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
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20 / MediaQuery.of(context).textScaleFactor),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (scoreController.text != '' &&
                  scoreController.text.length > 2) {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pushReplacementNamed(HomePage.id);
                DatabaseHelper.addScoreboardPlayer(Player(
                    name: scoreController.text, score: prov.currentScore));
              }
            },
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: const BorderSide(color: Colors.white, width: 3),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
            ),
            child: Text('Done',
                style: TextStyle(
                    fontSize: 20 / MediaQuery.of(context).textScaleFactor)),
          ),
        ],
      ),
      onWillPopActive: true,
      useRootNavigator: true,
      style: AlertStyle(
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: 30 / MediaQuery.of(context).textScaleFactor,
        ),
        isButtonVisible: false,
        backgroundColor: Colors.black54,
        isCloseButton: false,
        descStyle: TextStyle(
            color: Colors.white,
            fontSize: 40 / MediaQuery.of(context).textScaleFactor),
      ),
    ).show();
  }

  void showAnswerDialog(BuildContext context, bool isCorrect) {
    final prov = Provider.of<QuestionsProvider>(context, listen: false);
    Alert(
      context: context,
      type: isCorrect ? AlertType.success : AlertType.error,
      onWillPopActive: true,
      useRootNavigator: true,
      buttons: [
        DialogButton(
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.transparent,
          onPressed: () {
            Navigator.of(context).pop();
            prov.isGameOver()
                ? showGameFinishDialog(context)
                : prov.nextQuestion();
          },
          child: Text(
            "Next Question",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20 / MediaQuery.of(context).textScaleFactor),
          ),
        )
      ],
      content: Column(
        children: [
          Text(
            "Answer",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30 / MediaQuery.of(context).textScaleFactor),
          ),
          Text(
            prov.currentQuestion.choices[prov.currentQuestion.answerNum],
            style: TextStyle(
              color: isCorrect ? Colors.green.shade300 : Colors.red.shade300,
              fontSize: 25 / MediaQuery.of(context).textScaleFactor,
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
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: Consumer<QuestionsProvider>(
            builder: (context, provider, child) {
              return Text(
                'Level ${provider.currentQuestionNum + 1}',
                style: TextStyle(fontSize: 35 / scaleFactor),
              );
            },
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                Consumer<QuestionsProvider>(
                  builder: (context, questionsProvider, child) {
                    return Text(
                      questionsProvider.questionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20 / scaleFactor,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 25),
                  itemBuilder: (context, index) {
                    return Consumer2<QuestionsProvider, AudioProvider>(
                      builder:
                          (context, questionsProvider, audioProvider, child) {
                        return ChoiceButton(
                          buttonText:
                              questionsProvider.currentQuestion.choices[index],
                          onPress: () {
                            bool isCorrect =
                                questionsProvider.isCorrectAnswer(index);
                            isCorrect
                                ? audioProvider.playCorrectAnswerAudio()
                                : audioProvider.playWrongAnswerAudio();
                            showAnswerDialog(context, isCorrect);
                          },
                        );
                      },
                    );
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
