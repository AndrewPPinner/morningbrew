// ignore_for_file: prefer_const_declarations, unnecessary_string_interpolations

import 'dart:convert';

import 'package:morningbrew/widgets/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB('todo.db');
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute(''' CREATE TABLE $tableItems (
      ${ItemFields.id} $idType, 
      ${ItemFields.title} $textType
    )''');
  }

  Future<Item> create(Item item) async {
    final db = await instance.database;

    final id = await db.insert(tableItems, item.toJson());

    return item.copy(id: id);
  }

  Future<Item> readItem(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableItems,
      columns: ItemFields.values,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Item>> readAllItems() async {
    final db = await instance.database;

    final order = '${ItemFields.id} ASC';

    final result = await db.query(tableItems, orderBy: order);

    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<int?> update(Item item) async {
    final db = await instance.database;

    return db.update(
      tableItems,
      item.toJson(),
      where: '${ItemFields.id} = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableItems,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
