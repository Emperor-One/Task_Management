import 'sub_task.dart';

class Task {
  final int? id;
  final String title;
  final String? notes;
  final DateTime? startTime;
  final DateTime? stopTime;
  bool isDone;
  final bool isImportant;
  final List<SubTasks>? subTasks;
  final String category;

  Task({
    this.id,
    required this.title,
    this.notes,
    this.startTime,
    this.stopTime,
    required this.isDone,
    required this.isImportant,
    this.subTasks = const [],
    required this.category,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json["id"],
      title: json["title"],
      notes: json["notes"],
      startTime: checkIfNullFirst(json["startTime"]),
      stopTime: checkIfNullFirst(json["stopTime"]),
      isDone: json["isDone"] == 1,
      isImportant: json["isImportant"] == 1,
      subTasks: json["subTasks"],
      category: json["category"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "notes": notes,
      "startTime": "$startTime",
      "stopTime": "$stopTime",
      "isDone": (isDone) ? 1 : 0,
      "isImportant": (isImportant) ? 1 : 0,
      "category": category,
    };
  }

  @override
  String toString() {
    return 'Task{id: $id, title: $title, notes: $notes, startTime: $startTime, stopTime: $stopTime, isDone: $isDone, isImportant: $isImportant, category: $category,\nsubTasks: $subTasks}\n';
  }

  static toDateTime(String? time, String? date) {
    print("TIME IS $time");
    if (time != null && time != "") {
      final splitTime = time.split(':');
      final splitDate = date!.split('-');
      return DateTime(
        int.parse(splitDate[0]),
        int.parse(splitDate[1]),
        int.parse(splitDate[2]),
        int.parse(splitTime[0]),
        int.parse(splitTime[1]),
      );
    }
  }

  static String timeString(DateTime? dateTime) {
    if (dateTime != null) {
      String dateTimeMinute =
          (dateTime.minute < 10) ? "0${dateTime.minute}" : "${dateTime.minute}";

      String dateTimeHour =
          (dateTime.hour < 10) ? "0${dateTime.hour}" : "${dateTime.hour}";
      return "$dateTimeHour:$dateTimeMinute";
    }
    return "";
  }

  static String dateString(DateTime? dateTime) {
    if (dateTime != null) {
      String dateTimeMonth =
          (dateTime.month < 10) ? "0${dateTime.month}" : "${dateTime.month}";
      String dateTimeDay =
          (dateTime.day < 10) ? "0${dateTime.day}" : "${dateTime.day}";
      return "${dateTime.year}-$dateTimeMonth-$dateTimeDay";
    }
    return "";
  }

  static DateTime? checkIfNullFirst(String? time) {
    print("TIME IS $time");
    return (time != "" && time != null && time != "null")
        ? DateTime.parse(time)
        : null;
  }
}
