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
}
