import '../data_providers/local_task_data_provider.dart';
import '../models/models.dart';

class LocalTaskRepository {
  final LocalTaskDataProvider dataProvider;

  LocalTaskRepository(this.dataProvider);

  Future<Task> createTask(Task task) async {
    return dataProvider.createTask(task);
  }

  Future<List<Task>> getTasks() async {
    return dataProvider.getTasks();
  }

  Future<List<Task>> getDoneTasks() async {
    return dataProvider.getTasks();
  }

  Future<Task> updateTask(Task task) async {
    return dataProvider.updateTask(task);
  }

  Future<void> deleteTask(Task task) async {
    return dataProvider.deleteTask(task);
  }
}
