import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:iquiz_flutter/models/game_state.dart";
import "package:iquiz_flutter/models/question.dart";
import "package:iquiz_flutter/services/database_helper.dart";

class QuestionsProvider extends ChangeNotifier {
  int _questionNum = 0;
  int _score = 0;

  List<Question> _questionsList = [];

  void startGame() {
    _questionNum = 0;
    _score = 0;
    getQuestions();
    notifyListeners();
  }

  void loadGame(GameState gameState) {
    getQuestions();
    _questionNum = gameState.questionNum;
    _score = gameState.score;
    notifyListeners();
  }

  void nextQuestion() async {
    _questionNum++;
    await DatabaseHelper.saveGameState(
        GameState(score: _score, questionNum: _questionNum));
    notifyListeners();
  }

  void getQuestions() async {
    String quesitonsString =
        await rootBundle.loadString('assets/questions.json');
    List quesitonsJson = json.decode(quesitonsString)["questions"];
    _questionsList =
        quesitonsJson.map((data) => Question.fromJson(data)).toList();
    notifyListeners();
  }

  bool isGameOver() {
    return _questionNum == _questionsList.length - 1;
  }

  bool isCorrectAnswer(int choiceNum) {
    bool isCorrect = choiceNum == currentQuestion.answerNum;
    if (isCorrect) _score++;
    return isCorrect;
  }

  // ------------------- Getters ----------------------

  Question get currentQuestion => _questionsList[_questionNum];

  String get questionText => currentQuestion.questionText;

  int get questionsLength => _questionsList.length;

  int get currentQuestionNum => _questionNum;

  int get currentScore => _score;
}
