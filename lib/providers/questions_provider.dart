import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionsProvider extends ChangeNotifier {
  int _questionNum = 0;
  int _score = 0;

  final List<Question> _questionsList = [
    Question(
      text:
          'What is the name of the biggest technology company in South Korea?',
      answerNum: 3,
      choices: ['Nokia', 'Apple', 'Microsoft', 'Samsung'],
    ),
    Question(
      text: 'Which animal can be seen on the Porsche logo?',
      answerNum: 0,
      choices: ['Horse', 'Jaguar', 'Ox', 'Lion'],
    ),
    Question(
      text: 'What is the rarest M&M color?',
      answerNum: 1,
      choices: ['Blue', 'Brown', 'Red', 'Yellow'],
    ),
    Question(
      text: 'Who was the first woman to win a Nobel Prize (in 1903)?',
      answerNum: 0,
      choices: [
        'Marie Curie',
        'Grazia Deledda',
        'Sigrid Undset',
        'Jane Addams',
      ],
    ),
    Question(
      text: 'What is the most consumed manufactured drink in the world?',
      answerNum: 2,
      choices: ['Water', 'Juice', 'Tea', 'Coffee'],
    ),
    Question(
      text: 'Which is the only food that never goes bad?',
      answerNum: 1,
      choices: ['Cheese', 'Honey', 'Bread', 'Sugar'],
    ),
    Question(
      text: 'Which country invented ice cream?',
      answerNum: 0,
      choices: ['China', 'Niger', 'Turkey', 'Ukraine'],
    ),
    Question(
      text: '“Stars and Stripes” is the nickname of the flag of which country?',
      answerNum: 3,
      choices: ['United Kingdom', 'Morocco', 'Syria', 'United States'],
    ),
    Question(
      text: 'What does WWW stands for ??',
      answerNum: 1,
      choices: [
        'Wild World Web',
        'World Wide Web',
        'Wonder Woman Web',
        'World Web War',
      ],
    ),
    Question(
      text: 'Which country consumes the most chocolate ??',
      answerNum: 3,
      choices: ['Brazil', 'Algeria', 'Poland', 'Switzerland'],
    ),
    Question(
      text: 'What was the first soft drink in outer space ??',
      answerNum: 0,
      choices: ['Coca Cola', 'Pepsi', 'Schweppes', 'Mountain Dew'],
    ),
    Question(
      text: 'What sport is known as the "king of sports" ??',
      answerNum: 2,
      choices: ['Baseball', 'Basketball', 'Soccer', 'Ice Hockey'],
    ),
    Question(
      text: 'What country is responsible for creating the Olympic Games ??',
      answerNum: 1,
      choices: ['Estonia', 'Greece', 'Finland', 'Japan'],
    ),
    Question(
      text: 'What geometric shape is generally used for stop signs?',
      answerNum: 0,
      choices: ['Octagon', 'Heptagon', 'Hexagon', 'Square'],
    ),
    Question(
      text: 'How many languages are written from right to left?',
      answerNum: 3,
      choices: ['9', '10', '11', '12'],
    ),
    Question(
      text: 'What color is a ruby?',
      answerNum: 1,
      choices: ['Green', 'Red', 'Blue', 'White'],
    ),
    Question(
      text: 'Who was the first president of the United States?',
      answerNum: 0,
      choices: [
        'George Washington',
        'Abraham Lincoln',
        'John Kennedy',
        'Richard Nixon',
      ],
    ),
    Question(
      text: 'What is the smallest country in the world?',
      answerNum: 2,
      choices: ['Malta', 'Singapore', 'Vatican City', 'Maldives'],
    ),
    Question(
      text: 'Which country borders 14 nations and crosses 8 time zones?',
      answerNum: 3,
      choices: ['Canada', 'India', 'Argentina', 'Russia'],
    ),
    Question(
      text: 'What country has the most natural lakes?',
      answerNum: 0,
      choices: ['Canada', 'Argentina', 'Norway', 'Sweden'],
    ),
    Question(
      text: 'How many hearts does an octopus have?',
      answerNum: 2,
      choices: ['1', '2', '3', '4'],
    ),
    Question(
      text: 'How long do elephant pregnancies last?',
      answerNum: 0,
      choices: ['22 months', '3 months', '9 months', '15 months'],
    ),
    Question(
      text: 'The name of which African animal means "river horse"?',
      answerNum: 3,
      choices: ['Crocodile', 'Sea Horse', 'Rays', 'Hippopotamus'],
    ),
    Question(
      text: 'What is the hottest planet in the solar system?',
      answerNum: 2,
      choices: ['Earth', 'Mercury', 'Venus', 'Jupiter'],
    ),
    Question(
      text: 'What tissues connect the muscles to the bones?',
      answerNum: 1,
      choices: ['Blood', 'Tendons', 'Ligaments', 'Cartilage'],
    ),
    Question(
      text: 'How many stars are there on the American flag?',
      answerNum: 2,
      choices: ['48', '49', '50', '51'],
    ),
    Question(
      text: 'What country gave the Statue of Liberty to the United States?',
      answerNum: 0,
      choices: ['France', 'England', 'China', 'Russia'],
    ),
    Question(
      text: 'What is the rarest type of blood?',
      answerNum: 1,
      choices: ['AB+', 'AB-', 'O+', 'O-'],
    ),
    Question(
      text: 'How many rings make up the Olympic logo?',
      answerNum: 1,
      choices: ['3', '5', '7', '9'],
    ),
    Question(
      text: 'What is the name of the currency of Japan?',
      answerNum: 3,
      choices: ['Pound', 'Renminbi', 'Won', 'Yen'],
    ),
    Question(
      text: 'How many bones are in elephant\'s trunk?',
      answerNum: 0,
      choices: ['0', '201', '50', '105'],
    ),
    Question(
      text: 'How many total dots on a dice?',
      answerNum: 2,
      choices: ['6', '12', '21', '0'],
    ),
    Question(
      text: 'In which country is Leaning Tower of Pisa?',
      answerNum: 0,
      choices: ['Italy', 'France', 'Germany', 'England'],
    ),
    Question(
      text: 'What is the name of Batman\'s city?',
      answerNum: 3,
      choices: ['Metropolis', 'New York', 'Central City', 'Gotham City'],
    ),
    Question(
      text: 'What colors are mixed together to make green?',
      answerNum: 1,
      choices: ['Blue & Red', 'Blue & Yellow', 'Red & Yellow', 'Red & Orange'],
    ),
    Question(
      text: 'How many bones in a human\'s body?',
      answerNum: 1,
      choices: ['300', '206', '250', '105'],
    ),
    Question(
      text: 'What is the name of the first Egyptian pyramid built?',
      answerNum: 3,
      choices: ['Khofo', 'Khafre', 'Menkaure', 'Djoser'],
    ),
    Question(
      text: 'What country invented paper?',
      answerNum: 0,
      choices: ['China', 'England', 'France', 'Egypt'],
    ),
    Question(
      text: 'What is the world\'s oldest currency still in use?',
      answerNum: 2,
      choices: [
        'French Franc',
        'American Dollar',
        'British Pound',
        'Indian Rupee',
      ],
    ),
    Question(
      text: 'What is the name of the country shaped like a boot?',
      answerNum: 2,
      choices: ['Finland', 'Qatar', 'Itlay', 'Indonesia'],
    ),
    Question(
      text: 'What is the name of the world\'s largest desert?',
      answerNum: 1,
      choices: ['Arctic', 'Sahara', 'Australia', 'Arabian'],
    ),
    Question(
      text: 'What land animal has the largest eyes?',
      answerNum: 0,
      choices: ['Ostrich', 'Chameleon', 'Owl', 'Frog'],
    ),
    Question(
      text: 'What precentage of water is in a watermelon?',
      answerNum: 3,
      choices: ['48 %', '62 %', '87 %', '92 %'],
    ),
    Question(
      text: 'What is the offspring of a male zebra and a female donkey called?',
      answerNum: 2,
      choices: ['Mule', 'Zorse', 'Zonkey', 'Donkra'],
    ),
    Question(
      text: 'Unicorn is the national animal of which country?',
      answerNum: 1,
      choices: ['Austria', 'Scotland', 'South Korea', 'Uganda'],
    ),
    Question(
      text: 'What language is spoken the most around the world?',
      answerNum: 2,
      choices: ['Arabic', 'Chinese', 'English', 'Hindi'],
    ),
    Question(
      text: 'In the U.S., what is the most popular flavour of ice cream?',
      answerNum: 3,
      choices: ['Vanilla', 'Strawberry', 'Toffee', 'Chocolate'],
    ),
    Question(
      text: 'What is the Mexican food name that translates as "little donkey"?',
      answerNum: 0,
      choices: ['Burrito', 'Frijoles Charros', 'Quesadillas', 'Tacos'],
    ),
    Question(
      text: 'From what country does Gouda cheese come?',
      answerNum: 0,
      choices: ['Netherlands', 'U.S.', 'France', 'Switzerland'],
    ),
    Question(
      text: 'What country in the world has the most KFC restaurants?',
      answerNum: 1,
      choices: ['United States', 'China', 'Japan', 'Russia'],
    ),
  ];

  Question getQuestion() {
    return _questionsList[_questionNum];
  }

  int getQuestionsLength() {
    return _questionsList.length;
  }

  int getQuestionNum() {
    return _questionNum;
  }

  int getScore() {
    return _score;
  }

  void nextQuestion() {
    _questionNum++;
    notifyListeners();
  }

  bool isCorrectAnswer(int choiceNum) {
    bool isCorrect = choiceNum == getQuestion().answerNum;
    if (isCorrect) _score++;
    return isCorrect;
  }

  void startGame() {
    _questionNum = 0;
    _score = 0;
    notifyListeners();
  }

  bool isFinished() {
    return _questionNum == _questionsList.length - 1;
  }
}
