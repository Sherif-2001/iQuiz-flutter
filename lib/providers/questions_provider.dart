import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:iquiz_flutter/models/level.dart';
import "package:iquiz_flutter/services/database_helper.dart";

class QuestionsProvider extends ChangeNotifier {
  int _questionNum = 0;

  List _questionsList = [];

  List _unlockedLevels = [];

  void fetchQuestions() async {
    String quesitonsString =
        await rootBundle.loadString('assets/questions.json');
    List quesitonsJson = json.decode(quesitonsString)["questions"];
    _questionsList = quesitonsJson.map((data) => Level.fromJson(data)).toList();
  }

  void newGame() async {
    _questionNum = 0;
    await DatabaseHelper.clearUnlockedLevels();
    notifyListeners();
  }

  void nextLevel() async {
    _questionNum++;
    await DatabaseHelper.unlockLevel(_questionNum);
    notifyListeners();
  }

  void selectLevel(int index) {
    _questionNum = index;
    notifyListeners();
  }

  bool isCorrectAnswer(int choiceNum) {
    return choiceNum == currentQuestion.answerNum;
  }

  void getUnlockedLevels() async {
    _unlockedLevels = await DatabaseHelper.getUnlockedLevels();
    notifyListeners();
  }

  // ------------------- Getters ----------------------

  Level get currentQuestion => _questionsList[_questionNum];

  String get questionText => currentQuestion.questionText;

  int get questionsLength => _questionsList.length;

  int get currentQuestionNum => _questionNum;

  List get unlockedLevels => _unlockedLevels;
}
