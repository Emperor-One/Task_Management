import 'package:test/test.dart';

import 'package:task_management/models/models.dart';
import 'package:task_management/data_providers/local_task_data_provider.dart';

void main() {
  test("description", () {
    Task task = const Task(
        title: "Do this fast",
        notes: "I would like to get this done real quick.",
        isDone: false,
        isImportant: false,
        category: "School");
  });
}
