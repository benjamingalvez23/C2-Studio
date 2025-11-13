import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('publicaciones.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textTypeNullable = 'TEXT';

    await db.execute('''
      CREATE TABLE publicaciones (
        id $idType,
        titulo $textType,
        descripcion $textType,
        unidad $textType,
        imagenPath $textTypeNullable,
        fecha $textType
      )
    ''');
  }

  Future<int> insertPublicacion(Map<String, dynamic> publicacion) async {
    final db = await instance.database;
    return await db.insert('publicaciones', publicacion);
  }

  Future<List<Map<String, dynamic>>> getAllPublicaciones() async {
    final db = await instance.database;
    return await db.query(
      'publicaciones',
      orderBy: 'fecha DESC',
    );
  }

  Future<int> deletePublicacion(int id) async {
    final db = await instance.database;
    return await db.delete(
      'publicaciones',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePublicacion(Map<String, dynamic> publicacion) async {
    final db = await instance.database;
    return await db.update(
      'publicaciones',
      publicacion,
      where: 'id = ?',
      whereArgs: [publicacion['id']],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}