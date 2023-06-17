import 'sub_tasks.dart';

class Task {
  final int id;
  final String title;
  final String notes;
  final String startTime;
  final String stopTime;
  final bool isDone;
  final bool isImportant;
  final List<SubTasks> subTasks;
  final String category;
  final String date;

  const Task(
      {required this.id,
      required this.title,
      required this.notes,
      required this.startTime,
      required this.stopTime,
      required this.isDone,
      required this.isImportant,
      required this.subTasks,
      required this.category,
      required this.date});

  factory Task.fromSQLTuple(List<dynamic> tuple) {
    return Task(
        id: tuple[0],
        title: tuple[1],
        notes: tuple[2],
        startTime: tuple[3],
        stopTime: tuple[4],
        isDone: tuple[5],
        isImportant: tuple[6],
        subTasks: tuple[7],
        category: tuple[8],
        date: tuple[9]);
  }
}
