import 'dart:io';

import 'package:nomba_routines/models/routine.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstrucroe();
  static final DatabaseHelper instance = DatabaseHelper._privateConstrucroe();

  static Database? _database;
  Future<Database> get database async => _database ??= await _iniDatabase();

  Future<Database> _iniDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'routines.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE routines(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
    );
  }

  Future<List<Routine>> getRoutines() async {
    Database db = await instance.database;
    var routines = await db.query('routines', orderBy: 'title');
    List<Routine> routineList = routines.isNotEmpty
        ? routines.map((e) => Routine.fromMap(e)).toList()
        : [];
    return routineList;
  }

  Future<int> insertRoutine(Routine routine) async {
    Database db = await instance.database;
    return await db.insert('routines', routine.toMap());
  }

  /*Future<Database> database() async {
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
  }*/

  /*Future<List<Routine>> getRoutines() async {
    Database _db = await database();
    List<Map<String, dynamic>> routinesMap = await _db.query('routines');
    return List.generate(routinesMap.length, (index) {
      return Routine(id: routinesMap[index]['id'], title: routinesMap[index]['title'], description: routinesMap[index]['description']);
    });
  }*/
}
