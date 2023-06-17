part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {
  final NotificationService notificationService = NotificationService();

  TaskInitial() {
    initNot();
  }

  void initNot() async {
    await notificationService.initNotification();
  }
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

enum TasKValidator { database }
