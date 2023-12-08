import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class DBConnection {
  static late Database _database;

  static Future<Database> getDatabase() async {
    DBHelper dbHelper = DBHelper();
    _database = await dbHelper.database;
    return _database;
  }

  static Future<void> closeDatabase() async {
    if (_database.isOpen) {
      await _database.close();
    }
  }
}
