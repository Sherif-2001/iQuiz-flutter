import 'package:sqflite/sqflite.dart';

const String levelsTable = "level";

class DatabaseHelper {
  static Future _createTables(Database database) async {
    await database.execute('''
CREATE TABLE $levelsTable(
  id INTEGER PRIMARY KEY
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

  // ------------------------ Levels Unlocked Methods -------------------

  static Future unlockLevel(int levelNum) async {
    final database = await _getDatabase();
    await database.query(levelsTable,
        where: "id = ?", whereArgs: [levelNum]).then((data) async {
      if (data.isEmpty) {
        database.insert(levelsTable, {"id": levelNum});
      }
    });
  }

  static Future getUnlockedLevels() async {
    final database = await _getDatabase();
    final data = await database.query(levelsTable);
    return data.map((map) => map["id"] as int).toList();
  }

  static Future clearUnlockedLevels() async {
    final database = await _getDatabase();
    await database.execute('''
DELETE FROM $levelsTable
''');
  }
}
