class SubTasks {
  final int? parentTaskId;
  final String title;
  final bool isDone;

  const SubTasks(
      {required this.parentTaskId, required this.title, required this.isDone});

  factory SubTasks.fromJson(Map<String, dynamic> json) {
    return SubTasks(parentTaskId: json["parentTaskId"], title: json[1], isDone: json[2]);
  }
}
