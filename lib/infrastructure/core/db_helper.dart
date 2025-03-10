import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'auth.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            email TEXT NOT NULL,
            faceId TEXT NOT NULL,
            fingerprint TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  static Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'LOWER(username) = ?', // Case-insensitive match
      whereArgs: [username.toLowerCase()],
    );

    print("📂 Debug: Database Query Result → $result");
    return result.isNotEmpty ? result.first : null;
  }

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users');
  }

  // Check database schema (for debugging)
  static Future<void> checkDatabaseSchema() async {
    final db = await database;
    List<Map<String, dynamic>> schema =
        await db.rawQuery("PRAGMA table_info(users)");
    print("📜 Debug: Table Schema → $schema");
  }
}
