class ScoreboardPlayer {
  late String playerName;
  late int playerScore;

  ScoreboardPlayer({this.playerName = "", this.playerScore = 0});

  Map<String, dynamic> toJson() {
    return {"playerName": playerName, "playerScore": playerScore};
  }

  ScoreboardPlayer.fromJson(Map<String, dynamic> json) {
    playerName = json["playerName"];
    playerScore = json["playerScore"];
  }
}
