class Question {
  final String text;
  final int answerNum;
  final List<String> choices;

  Question(
      {required this.choices, required this.answerNum, required this.text});
}
