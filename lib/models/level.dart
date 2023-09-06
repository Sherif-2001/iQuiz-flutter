class Level {
  final String questionText;
  final int answerNum;
  final List choices;

  Level({
    required this.choices,
    required this.answerNum,
    required this.questionText,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      questionText: json["question"],
      answerNum: int.parse(json["answerNum"]),
      choices: json["answers"],
    );
  }
}
