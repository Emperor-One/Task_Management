import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/models.dart';

class LocalTaskDataProvider {
  Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      notes TEXT,
      startTime TEXT DEFAULT "",
      stopTime TEXT DEFAULT "",
      isDone INTEGER DEFAULT 0,
      isImportant INTEGER,
      category TEXT DEFAULT "",
      date TEXT
    )""");

    await database.execute("""CREATE TABLE IF NOT EXISTS subTasks(
      parentTaskId INTEGER,
      title text DEFAULT "",
      isDone INTEGER DEFAULT 0,
      FOREIGN KEY (parentTaskId) REFERENCES tasks (id) ON DELETE CASCADE ON UPDATE CASCADE
    )""");
  }

  Future<Database> db() async {
    return openDatabase(join(await getDatabasesPath(), 'task_management.db'),
        version: 1, onCreate: (database, version) async {
      await createTables(database);
    });
  }

  Future<Task> createTask(Task task) async {
    final db = await this.db();

    final taskData = task.toJson();

    final id = await db.insert('tasks', taskData,
        conflictAlgorithm: ConflictAlgorithm.replace);

    final subTasks = task.subTasks!.map((subtask) {
      return {
        "parentTaskId": id,
        "title": subtask.title,
        "isDone": subtask.isDone
      };
    }).toList();

    for (final subTaskData in subTasks) {
      await db.insert('subTasks', subTaskData,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    final createdTask =
        await db.query('tasks', where: "id = ?", whereArgs: [id], limit: 1);
    return Task.fromJson(createdTask[0]);
  }

  Future<List<Task>> getTasks() async {
    final db = await this.db();

    final tasks = await db.query('tasks', orderBy: "id");

    List<Task> listOfTasks = tasks.map((task) {
      return Task.fromJson(task);
    }).toList();

    return listOfTasks;
  }

  Future<List<Map<String, dynamic>>> getSubTasks(Task task) async {
    final db = await this.db();

    return db.query('subTasks',
        where: "parentTaskId = ?", whereArgs: [task.id], orderBy: "id");
  }

  Future<int> updateTask(Task task) async {
    final db = await this.db();

    final taskData = task.toJson();

    final rowsAffected = await db
        .update('tasks', taskData, where: "id = ?", whereArgs: [task.id]);

    final subTasks = task.subTasks!.map((subtask) {
      return {
        "parentTaskId": task.id,
        "title": subtask.title,
        "isDone": subtask.isDone
      };
    });

    for (final subTaskData in subTasks) {
      await db.update('subTasks', subTaskData,
          where: "parentTaskId = ?", whereArgs: [task.id]);
    }

    return rowsAffected;
  }
}
