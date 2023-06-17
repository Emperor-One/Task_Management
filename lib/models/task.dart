import 'sub_task.dart';

class Task {
  final int? id;
  final String title;
  final String? notes;
  final String? startTime;
  final String? stopTime;
  final bool isDone;
  final bool isImportant;
  final List<SubTasks>? subTasks;
  final String category;
  final String? date;

  const Task(
      {this.id,
      required this.title,
      this.notes,
      this.startTime,
      this.stopTime,
      required this.isDone,
      required this.isImportant,
      this.subTasks = const [],
      required this.category,
      this.date});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        title: json["title"],
        notes: json["notes"],
        startTime: json["startTime"],
        stopTime: json["stopTime"],
        isDone: json["isDone"] == 1,
        isImportant: json["isImportant"] == 1,
        subTasks: json["subTasks"],
        category: json["category"],
        date: json["date"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "notes": notes,
      "startTime": startTime,
      "stopTime": stopTime,
      "isDone": (isDone) ? 1: 0,
      "isImportant": (isImportant) ? 1: 0,
      "category": category,
      "date": date
    };
  }
}
