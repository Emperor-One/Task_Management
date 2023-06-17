class SubTasks {
  final String title;
  final bool isDone;

  const SubTasks({required this.title, required this.isDone});

  factory SubTasks.fromSQLTuple(List<dynamic> tuple) {
    return SubTasks(title: tuple[0], isDone: tuple[1]);
  }
}
