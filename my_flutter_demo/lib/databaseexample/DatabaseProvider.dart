import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/ToDoListItem.dart';

class DatabaseProvider {

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDatabase();
    }
    return _database;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String directoryPath = join(documentsDirectory.path, "ToDoList.db");
    return await openDatabase(directoryPath, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE todo (id INTEGER PRIMARY KEY, item TEXT, isDone BOOLEAN)");
      await db.execute("CREATE TABLE USER (id INTEGER PRIMARY KEY, name TEXT)");
    });
  }

  insertToDoItem(ToDoListItem todoItem) async {
    var db = await database;
    await db.insert("todo", todoItem.toMap());
  }

  Future<List<ToDoListItem>> fetchAllToDoItems () async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("todo");
    List<ToDoListItem> listOfitems = List.generate(result.length, (i) {
      return ToDoListItem(id: result[i]['id'], item: result[i]['item'], isDone: result[i]['isDone']);
    });
    return listOfitems;
  }
}
