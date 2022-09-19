// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/models/scoreboard_player.dart';
import 'package:game/pages/home_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'models/question.dart';
import 'package:game/constants.dart';
import 'notification_service.dart';

class Brain extends ChangeNotifier {
  int _questionNum = 0;
  int _score = 0;
  List<ScoreboardPlayer> _scoreboardPlayers = [];
  bool isGameStarted = false;
  final scoreController = TextEditingController();
  final clickAudioPlayer = AudioPlayer();
  final answerAudioPlayer = AudioPlayer();
  bool isPlayingMusic = true;

  List<Question> _questionsList = [
    Question(
      questionText:
          'What is the name of the biggest technology company in South Korea?',
      questionAnswerNum: 4,
      choice1: 'Nokia',
      choice2: 'Apple',
      choice3: 'Microsoft',
      choice4: 'Samsung',
    ),
    Question(
      questionText: 'Which animal can be seen on the Porsche logo?',
      questionAnswerNum: 1,
      choice1: 'Horse',
      choice2: 'Jaguar',
      choice3: 'Ox',
      choice4: 'Lion',
    ),
    Question(
      questionText: 'What is the rarest M&M color?',
      questionAnswerNum: 2,
      choice1: 'Blue',
      choice2: 'Brown',
      choice3: 'Red',
      choice4: 'Yellow',
    ),
    Question(
      questionText: 'Who was the first woman to win a Nobel Prize (in 1903)?',
      questionAnswerNum: 1,
      choice1: 'Marie Curie',
      choice2: 'Grazia Deledda',
      choice3: 'Sigrid Undset',
      choice4: 'Jane Addams',
    ),
    Question(
      questionText:
          'What is the most consumed manufactured drink in the world?',
      questionAnswerNum: 3,
      choice1: 'Water',
      choice2: 'Juice',
      choice3: 'Tea',
      choice4: 'Coffee',
    ),
    Question(
      questionText: 'Which is the only food that never goes bad?',
      questionAnswerNum: 2,
      choice1: 'Cheese',
      choice2: 'Honey',
      choice3: 'Bread',
      choice4: 'Sugar',
    ),
    Question(
      questionText: 'Which country invented ice cream?',
      questionAnswerNum: 1,
      choice1: 'China',
      choice2: 'Niger',
      choice3: 'Turkey',
      choice4: 'Ukraine',
    ),
    Question(
      questionText:
          '“Stars and Stripes” is the nickname of the flag of which country?',
      questionAnswerNum: 4,
      choice1: 'United Kingdom',
      choice2: 'Morocco',
      choice3: 'Syria',
      choice4: 'United States',
    ),
    Question(
      questionText: 'What does WWW stands for ??',
      questionAnswerNum: 2,
      choice1: 'Wild World Web',
      choice2: 'World Wide Web',
      choice3: 'Wonder Woman Web',
      choice4: 'World Web War',
    ),
    Question(
      questionText: 'Which country consumes the most chocolate ??',
      questionAnswerNum: 4,
      choice1: 'Brazil',
      choice2: 'Algeria',
      choice3: 'Poland',
      choice4: 'Switzerland',
    ),
    Question(
      questionText: 'What was the first soft drink in outer space ??',
      questionAnswerNum: 1,
      choice1: 'Coca Cola',
      choice2: 'Pepsi',
      choice3: 'Schweppes',
      choice4: 'Mountain Dew',
    ),
    Question(
      questionText: 'What sport is known as the "king of sports" ??',
      questionAnswerNum: 3,
      choice1: 'Baseball',
      choice2: 'Basketball',
      choice3: 'Soccer',
      choice4: 'Ice Hockey',
    ),
    Question(
      questionText:
          'What country is responsible for creating the Olympic Games ??',
      questionAnswerNum: 2,
      choice1: 'Estonia',
      choice2: 'Greece',
      choice3: 'Finland',
      choice4: 'Japan',
    ),
    Question(
      questionText: 'What geometric shape is generally used for stop signs?',
      questionAnswerNum: 1,
      choice1: 'Octagon',
      choice2: 'Heptagon',
      choice3: 'Hexagon',
      choice4: 'Square',
    ),
    Question(
      questionText: 'How many languages are written from right to left?',
      questionAnswerNum: 4,
      choice1: '9',
      choice2: '10',
      choice3: '11',
      choice4: '12',
    ),
    Question(
      questionText: 'What color is a ruby?',
      questionAnswerNum: 2,
      choice1: 'Green',
      choice2: 'Red',
      choice3: 'Blue',
      choice4: 'White',
    ),
    Question(
      questionText: 'Who was the first president of the United States?',
      questionAnswerNum: 1,
      choice1: 'George Washington',
      choice2: 'Abraham Lincoln',
      choice3: 'John Kennedy',
      choice4: 'Richard Nixon',
    ),
    Question(
      questionText: 'What is the smallest country in the world?',
      questionAnswerNum: 3,
      choice1: 'Malta',
      choice2: 'Singapore',
      choice3: 'Vatican City',
      choice4: 'Maldives',
    ),
    Question(
      questionText:
          'Which country borders 14 nations and crosses 8 time zones?',
      questionAnswerNum: 4,
      choice1: 'Canada',
      choice2: 'India',
      choice3: 'Argentina',
      choice4: 'Russia',
    ),
    Question(
      questionText: 'What country has the most natural lakes?',
      questionAnswerNum: 1,
      choice1: 'Canada',
      choice2: 'Argentina',
      choice3: 'Norway',
      choice4: 'Sweden',
    ),
    Question(
      questionText: 'How many hearts does an octopus have?',
      questionAnswerNum: 3,
      choice1: '1',
      choice2: '2',
      choice3: '3',
      choice4: '4',
    ),
    Question(
      questionText: 'How long do elephant pregnancies last?',
      questionAnswerNum: 1,
      choice1: '22 months',
      choice2: '3 months',
      choice3: '9 months',
      choice4: '15 months',
    ),
    Question(
      questionText: 'The name of which African animal means "river horse"?',
      questionAnswerNum: 4,
      choice1: 'Crocodile',
      choice2: 'Sea Horse',
      choice3: 'Rays',
      choice4: 'Hippopotamus',
    ),
    Question(
      questionText: 'What is the hottest planet in the solar system?',
      questionAnswerNum: 3,
      choice1: 'Earth',
      choice2: 'Mercury',
      choice3: 'Venus',
      choice4: 'Jupiter',
    ),
    Question(
      questionText: 'What tissues connect the muscles to the bones?',
      questionAnswerNum: 2,
      choice1: 'Blood',
      choice2: 'Tendons',
      choice3: 'Ligaments',
      choice4: 'Cartilage',
    ),
    Question(
      questionText: 'How many stars are there on the American flag?',
      questionAnswerNum: 3,
      choice1: '48',
      choice2: '49',
      choice3: '50',
      choice4: '51',
    ),
    Question(
      questionText:
          'What country gave the Statue of Liberty to the United States?',
      questionAnswerNum: 1,
      choice1: 'France',
      choice2: 'England',
      choice3: 'China',
      choice4: 'Russia',
    ),
    Question(
      questionText: 'What is the rarest type of blood?',
      questionAnswerNum: 2,
      choice1: 'AB+',
      choice2: 'AB-',
      choice3: 'O+',
      choice4: 'O-',
    ),
    Question(
      questionText: 'How many rings make up the Olympic logo?',
      questionAnswerNum: 2,
      choice1: '3',
      choice2: '5',
      choice3: '7',
      choice4: '9',
    ),
    Question(
      questionText: 'What is the name of the currency of Japan?',
      questionAnswerNum: 4,
      choice1: 'Pound',
      choice2: 'Renminbi',
      choice3: 'Won',
      choice4: 'Yen',
    ),
    Question(
      questionText: 'How many bones are in elephant\'s trunk?',
      questionAnswerNum: 1,
      choice1: '0',
      choice2: '201',
      choice3: '50',
      choice4: '105',
    ),
    Question(
      questionText: 'How many total dots on a dice?',
      questionAnswerNum: 3,
      choice1: '6',
      choice2: '12',
      choice3: '21',
      choice4: '0',
    ),
    Question(
      questionText: 'In which country is Leaning Tower of Pisa?',
      questionAnswerNum: 1,
      choice1: 'Italy',
      choice2: 'France',
      choice3: 'Germany',
      choice4: 'England',
    ),
    Question(
      questionText: 'What is the name of Batman\'s city?',
      questionAnswerNum: 4,
      choice1: 'Metropolis',
      choice2: 'New York',
      choice3: 'Central City',
      choice4: 'Gotham',
    ),
    Question(
      questionText: 'What colors are mixed together to make green?',
      questionAnswerNum: 2,
      choice1: 'Blue & Red',
      choice2: 'Blue & Yellow',
      choice3: 'Red & Yellow',
      choice4: 'Red & Orange',
    ),
    Question(
      questionText: 'How many bones in a human\'s body?',
      questionAnswerNum: 2,
      choice1: '300',
      choice2: '206',
      choice3: '250',
      choice4: '105',
    ),
    Question(
      questionText: 'What is the name of the first Egyptian pyramid built?',
      questionAnswerNum: 4,
      choice1: 'Khofo',
      choice2: 'Khafre',
      choice3: 'Menkaure',
      choice4: 'Djoser',
    ),
    Question(
      questionText: 'What country invented paper?',
      questionAnswerNum: 1,
      choice1: 'China',
      choice2: 'England',
      choice3: 'France',
      choice4: 'Egypt',
    ),
    Question(
      questionText: 'What is the world\'s oldest currency still in use?',
      questionAnswerNum: 3,
      choice1: 'French Franc',
      choice2: 'American Dollar',
      choice3: 'British Pound',
      choice4: 'Indian Rupee',
    ),
    Question(
      questionText: 'What is the name of the country shaped like a boot?',
      questionAnswerNum: 3,
      choice1: 'Finland',
      choice2: 'Qatar',
      choice3: 'Itlay',
      choice4: 'Indonesia',
    ),
    Question(
      questionText: 'What is the name of the world\'s largest desert?',
      questionAnswerNum: 2,
      choice1: 'Arctic',
      choice2: 'Sahara',
      choice3: 'Australia',
      choice4: 'Arabian',
    ),
    Question(
      questionText: 'What land animal has the largest eyes?',
      questionAnswerNum: 1,
      choice1: 'Ostrich',
      choice2: 'Chameleon',
      choice3: 'Owl',
      choice4: 'Frog',
    ),
    Question(
      questionText: 'What precentage of water is in a watermelon?',
      questionAnswerNum: 4,
      choice1: '48 %',
      choice2: '62 %',
      choice3: '87 %',
      choice4: '92 %',
    ),
    Question(
      questionText:
          'What is the offspring of a male zebra and a female donkey called?',
      questionAnswerNum: 3,
      choice1: 'Mule',
      choice2: 'Zorse',
      choice3: 'Zonkey',
      choice4: 'Donkra',
    ),
    Question(
      questionText: 'Unicorn is the national animal of which country?',
      questionAnswerNum: 2,
      choice1: 'Austria',
      choice2: 'Scotland',
      choice3: 'South Korea',
      choice4: 'Uganda',
    ),
    Question(
      questionText: 'What language is spoken the most around the world?',
      questionAnswerNum: 3,
      choice1: 'Arabic',
      choice2: 'Chinese',
      choice3: 'English',
      choice4: 'Hindi',
    ),
    Question(
      questionText:
          'In the U.S., what is the most popular flavour of ice cream?',
      questionAnswerNum: 4,
      choice1: 'Vanilla',
      choice2: 'Strawberry',
      choice3: 'Toffee',
      choice4: 'Chocolate',
    ),
    Question(
      questionText:
          'What is the Mexican food name that translates as "little donkey"?',
      questionAnswerNum: 1,
      choice1: 'Burrito',
      choice2: 'Frijoles Charros',
      choice3: 'Quesadillas',
      choice4: 'Tacos',
    ),
    Question(
      questionText: 'From what country does Gouda cheese come?',
      questionAnswerNum: 1,
      choice1: 'Netherlands',
      choice2: 'U.S.',
      choice3: 'France',
      choice4: 'Switzerland',
    ),
    Question(
      questionText: 'What country in the world has the most KFC restaurants?',
      questionAnswerNum: 2,
      choice1: 'United States',
      choice2: 'China',
      choice3: 'Japan',
      choice4: 'Russia',
    ),
  ];

  void saveAndGetScoreboard(States state) async {
    List<ScoreboardPlayer> tempList = [];
    final prefs = await SharedPreferences.getInstance();
    if (state == States.save) {
      prefs.setString("Players", jsonEncode(_scoreboardPlayers));
    } else if (state == States.load) {
      _scoreboardPlayers.clear();
      String jsonData = prefs.getString("Players")!;
      List<dynamic> decodedData = jsonDecode(jsonData);
      for (var map in decodedData) {
        tempList.add(ScoreboardPlayer(
            playerName: map["playerName"], playerScore: map["playerScore"]));
        _scoreboardPlayers = (tempList
              ..sort(
                (a, b) => a.playerScore.compareTo(b.playerScore),
              ))
            .reversed
            .toList();
      }
    }
    notifyListeners();
  }

  void saveAndLoadGame(States state) async {
    final prefs = await SharedPreferences.getInstance();
    if (state == States.save) {
      prefs.setInt("score", _score);
      prefs.setInt("questionNum", _questionNum);
      prefs.setBool("isGameStarted", isGameStarted);
    } else if (state == States.load) {
      _score = prefs.getInt("score")!;
      _questionNum = prefs.getInt("questionNum")!;
      isGameStarted = prefs.getBool("isGameStarted")!;
    }
    notifyListeners();
  }

  String getQuestionText() {
    return _questionsList[_questionNum].questionText;
  }

  int getQuestionAnswerNum() {
    return _questionsList[_questionNum].questionAnswerNum;
  }

  int getQuestionNum() {
    return _questionNum;
  }

  int getScoreValue() {
    return _score;
  }

  String getChoicesText(int choiceNum) {
    switch (choiceNum) {
      case 1:
        return _questionsList[_questionNum].choice1;

      case 2:
        return _questionsList[_questionNum].choice2;

      case 3:
        return _questionsList[_questionNum].choice3;

      case 4:
        return _questionsList[_questionNum].choice4;
    }
    return "";
  }

  List<ScoreboardPlayer> getPlayersList() {
    return _scoreboardPlayers;
  }

  void nextQuestion() {
    _questionNum++;
    notifyListeners();
  }

  void deletePlayer(int index) {
    _scoreboardPlayers.removeAt(index);
    saveAndGetScoreboard(States.save);
  }

  bool checkAnswer(int choiceNum) {
    if (choiceNum == getQuestionAnswerNum()) {
      _score++;
      return true;
    } else {
      return false;
    }
  }

  void startGame() {
    _questionNum = 0;
    _score = 0;
    isGameStarted = true;
    notifyListeners();
  }

  bool isFinished() {
    if (_questionNum == _questionsList.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void showSettings(BuildContext context) {
    Alert(
            context: context,
            title: "Settings",
            content: Column(
              children: [
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Music",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (isPlayingMusic) {
                              musicAudioPlayer.setVolume(0);
                              isPlayingMusic = false;
                            } else {
                              musicAudioPlayer.setVolume(1);
                              isPlayingMusic = true;
                            }
                          },
                          icon: Icon(
                            isPlayingMusic
                                ? Icons.headphones
                                : Icons.headset_off,
                            color: Colors.white,
                            size: 30,
                          ))
                    ]),
              ],
            ),
            style: AlertStyle(
                titleStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                isButtonVisible: false,
                backgroundColor: Colors.black54,
                descStyle: TextStyle(color: Colors.white, fontSize: 40)))
        .show();
    notifyListeners();
  }

  void onExit(BuildContext context) {
    Alert(
            context: context,
            type: AlertType.info,
            onWillPopActive: true,
            useRootNavigator: true,
            buttons: [
              DialogButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.transparent,
                  onPressed: () {
                    final notificationServices = NotificationServices();

                    notificationServices.initializeNotifications();
                    notificationServices.sendNotification("🔔See you soon🔔",
                        "Hope you had fun playing our game 😊");

                    SystemNavigator.pop();
                  }),
              DialogButton(
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.transparent,
                  onPressed: () {
                    musicAudioPlayer.resume();
                    Navigator.pop(context);
                  })
            ],
            desc: "Exit??",
            style: AlertStyle(
                isCloseButton: false,
                backgroundColor: Colors.black54,
                descStyle: TextStyle(color: Colors.white, fontSize: 30)))
        .show();
    notifyListeners();
  }

  void showScore(BuildContext context) {
    Alert(
      context: context,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              'Score: $_score/${_questionsList.length}',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 30),
            textAlign: TextAlign.center,
            controller: scoreController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)),
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              clickAudioPlayer.play(AssetSource('click.mp3'));
              if (scoreController.text != '') {
                _scoreboardPlayers.add(ScoreboardPlayer(
                    playerName: scoreController.text, playerScore: _score));
                Navigator.of(context).pushReplacementNamed(HomePage.id);
                saveAndGetScoreboard(States.save);
                isGameStarted = false;
                saveAndLoadGame(States.save);
              }
            },
            child: Text('Done', style: TextStyle(fontSize: 20)),
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              side: BorderSide(color: Colors.white, width: 3),
              primary: Colors.transparent,
              onPrimary: Colors.white,
            ),
          ),
        ],
      ),
      onWillPopActive: true,
      useRootNavigator: true,
      style: AlertStyle(
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
    notifyListeners();
  }

  void onChoice(BuildContext context, var alertType, bool isCorrect) {
    Alert(
            context: context,
            type: alertType,
            onWillPopActive: true,
            useRootNavigator: true,
            buttons: [
              DialogButton(
                  child: Text(
                    "Next Question",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.transparent,
                  onPressed: () {
                    saveAndLoadGame(States.save);
                    Navigator.of(context).pop();
                    if (isFinished()) {
                      showScore(context);
                    } else {
                      nextQuestion();
                    }
                    clickAudioPlayer.play(AssetSource('click.mp3'));
                    clickAudioPlayer.dispose();
                  })
            ],
            content: Column(
              children: [
                Text("Answer",
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                Text(getChoicesText(getQuestionAnswerNum()),
                    style: TextStyle(
                        color: isCorrect
                            ? Colors.green.shade300
                            : Colors.red.shade300,
                        fontSize: 25))
              ],
            ),
            style: AlertStyle(
                isCloseButton: false,
                alertBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: isCorrect ? Colors.green : Colors.red)),
                backgroundColor: Colors.black54,
                descStyle: TextStyle(color: Colors.white, fontSize: 20)))
        .show();
    notifyListeners();
  }
}
