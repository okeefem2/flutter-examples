// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

class DBHelper {
  // static Future<Database> database() async {
  //   // Opens if exists, or creates if does not
  //   final dbPath = await getDatabasesPath();
  //   return openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
  //     return db.execute(
  //         'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
  //   }, version: 1);
  // }

  // static Future<void> insert(String table, Map<String, dynamic> data) async {
  //   final db = await DBHelper.database();

  //   db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // static Future<List<Map<String, dynamic>>> fetch(String table) async {
  //   final db = await DBHelper.database();
  //   // Select * from table;
  //   return db.query(table);
  // }
}
