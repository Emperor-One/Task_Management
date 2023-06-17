part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class TaskLoad extends TaskEvent {
  const TaskLoad();

  @override
  List<Object> get props => [];
}

class CreateTask extends TaskEvent {
  final Task task;
  const CreateTask({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  final bool isTimeUpdated;
  const UpdateTask({required this.task, required this.isTimeUpdated});

  @override
  List<Object> get props => [task, isTimeUpdated];
}

class DeleteTask extends TaskEvent {
  final Task task;
  const DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}
