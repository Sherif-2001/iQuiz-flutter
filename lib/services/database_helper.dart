import 'package:game/models/player.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = "scoreboard";

class DatabaseHelper {
  static Future _createTable(Database database) async {
    await database.execute('''
CREATE TABLE $tableName(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name TEXT,
  score INTEGER
)
''');
  }

  static Future<Database> _getDatabase() async {
    return openDatabase(
      "database.db",
      version: 1,
      onCreate: (db, version) async {
        await _createTable(db);
      },
    );
  }

  static void closeDatabase() async {
    final database = await _getDatabase();
    database.isOpen ? database.close() : null;
  }

  static Future<List<Player>?> getAllData() async {
    final database = await _getDatabase();
    final List<Map<String, dynamic>> maps =
        await database.query(tableName, orderBy: "id");
    if (maps.isEmpty) return null;
    return List.generate(maps.length, (index) => Player.fromJson(maps[index]));
  }

  static Future<int> insertPlayer(Player scoreboardPlayer) async {
    final database = await _getDatabase();
    final id = await database.insert(tableName, scoreboardPlayer.toJson());
    return id;
  }

  static Future deletePlayer(int id) async {
    final database = await _getDatabase();
    try {
      database.delete(tableName, where: "id=?", whereArgs: [id]);
    } catch (e) {
      print("Something went wrong during deleting an item: $e");
    }
  }
}
