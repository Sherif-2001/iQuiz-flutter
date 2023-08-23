class Question {
  final String questionText;
  final int answerNum;
  final List choices;

  Question(
      {required this.choices,
      required this.answerNum,
      required this.questionText});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json["question"],
      answerNum: int.parse(json["answerNum"]),
      choices: json["answers"],
    );
  }
}
