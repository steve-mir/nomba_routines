import 'package:nomba_routines/models/routine.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), 'routines.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE routines(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
      );
    }, version: 1);
  }

  Future<void> InsertRoutines(Routine routine) async {
    Database _db = await database();
    await _db.insert('routines', routine.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /*Future<List<Routine>> getRoutines() async {
    Database _db = await database();
    List<Map<String, dynamic>> routinesMap = await _db.query('routines');
    return List.generate(routinesMap.length, (index) {
      return Routine(id: routinesMap[index]['id'], title: routinesMap[index]['title'], description: routinesMap[index]['description']);
    });
  }*/
}
