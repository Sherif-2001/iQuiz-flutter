class GameState {
  int score;
  int questionNum;

  GameState({required this.score, required this.questionNum});

  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      score: json["score"],
      questionNum: json["questionNum"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"score": score, "questionNum": questionNum};
  }

}
