import 'package:iquiz_flutter/models/game_state.dart';
import 'package:iquiz_flutter/models/player.dart';
import 'package:sqflite/sqflite.dart';

const String scoreboardTable = "scoreboard";
const String gameStateTable = "gamestate";

class DatabaseHelper {
  static Future _createTables(Database database) async {
    await database.execute('''
CREATE TABLE $scoreboardTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name TEXT,
  score INTEGER
)
''');
    await database.execute('''
CREATE TABLE $gameStateTable(
  questionNum INTEGER,
  score INTEGER
)
''');
  }

  static Future<Database> _getDatabase() async {
    return openDatabase(
      "database.db",
      version: 1,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  static void closeDatabase() async {
    final database = await _getDatabase();
    database.isOpen ? database.close() : null;
  }

  // ----------------------- Scoreboard Methods -------------------------

  static Future<List<Player>?> getScoreboardData() async {
    final database = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await database.query(scoreboardTable, orderBy: "id");
    if (maps.isEmpty) return null;
    return List.generate(maps.length, (index) => Player.fromJson(maps[index]));
  }

  static Future<int> addScoreboardPlayer(Player scoreboardPlayer) async {
    final database = await _getDatabase();
    final id =
        await database.insert(scoreboardTable, scoreboardPlayer.toJson());
    return id;
  }

  static Future deleteScoreboardPlayer(int id) async {
    final database = await _getDatabase();
    try {
      database.delete(scoreboardTable, where: "id=?", whereArgs: [id]);
    } catch (e) {
      print("Something went wrong during deleting an item: $e");
    }
  }

  // ------------------------ Game State Methods -------------------

  static Future saveGameState(GameState gameState) async {
    final database = await _getDatabase();
    final List<Map<String, dynamic>> dataMaps =
        await database.query(gameStateTable);

    if (dataMaps.isEmpty) {
      database.insert(gameStateTable, gameState.toJson());
    } else {
      database.update(gameStateTable, gameState.toJson());
    }
  }

  static Future loadGameState() async {
    final database = await _getDatabase();
    final List<Map<String, dynamic>> dataMaps =
        await database.query(gameStateTable);
    if (dataMaps.isEmpty) return null;
    return GameState.fromJson(dataMaps.first);
  }
}
