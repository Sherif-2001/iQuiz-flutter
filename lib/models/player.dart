class Player {
  int? id;
  String name;
  int score;

  Player({this.id, required this.name, required this.score});

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() {
    return {"name": name, "score": score};
  }
}
