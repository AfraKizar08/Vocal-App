// lib/services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'music.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE songs(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, artist TEXT, filepath TEXT, coverImage TEXT)',
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> getSongsByTitle(String title) async {
    final db = await database;
    return await db.query(
      'songs',
      where: 'title LIKE ? OR artist LIKE ?',
      whereArgs: ['%$title%', '%$title%'], // Search in both title and artist
      orderBy: 'id DESC',
    );
  }

  Future<void> insertSong(Map<String, dynamic> song) async {
    final db = await database;
    await db.insert('songs', song);
  }

  Future<List<Map<String, dynamic>>> getSongs() async {
    final db = await database;
    return await db.query('songs', orderBy: 'id DESC');
  }

  Future<void> deleteSong(int id) async {
    final db = await database;
    await db.delete('songs', where: 'id = ?', whereArgs: [id]);
  }
}