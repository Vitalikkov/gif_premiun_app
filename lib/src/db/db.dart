import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gif_premiun_app/src/modal/CardGifsModal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._();

  static Database? _database;

  DatabaseProvider._();

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_database.db');

    databaseFactory = databaseFactoryFfi;


    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE IF NOT EXISTS saved_cards (
          id TEXT PRIMARY KEY,
          url TEXT,
          preview TEXT,
          content_description TEXT
        )
      ''');
      },
    );

    return database;
  }

  static Future<void> insertCard(SavedCard card) async {
    final db = await database;
    await db.insert('cards', card.toMap());
  }

  static Future<List<SavedCard>> getSavedCards() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cards');
    return List.generate(
      maps.length,
          (index) => SavedCard(
        id: maps[index]['id'],
        url: maps[index]['url'],
        preview: maps[index]['preview'],
        contentDescription: maps[index]['content_description'],
      ),
    );
  }

  static Future<void> deleteCard(String id) async {
    final db = await database;
    await db.delete('cards', where: 'id = ?', whereArgs: [id]);
  }
}
