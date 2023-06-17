import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/local_task_reposiotry.dart';
import '../services/notification_service.dart';
import '../models/models.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final LocalTaskRepository localTaskRepository;
  final NotificationService notificationService = NotificationService();
  TaskBloc({required this.localTaskRepository}) : super(TaskInitial()) {
    on<TaskLoad>((event, emit) async {
      emit(TaskLoading());
      final tasks = await localTaskRepository.getTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<CreateTask>(
      (event, emit) async {
        emit(TaskLoading());
        Task createdTask = await localTaskRepository.createTask(event.task);
        final tasks = await localTaskRepository.getTasks();
        emit(TaskLoaded(tasks: tasks));
        if (createdTask.startTime != null) {
          await notificationService.scheduleNotification(createdTask);
          print("Notification Scheduled");
        }
        print(state as TaskLoaded);
      },
    );

    on<UpdateTask>(
      (event, emit) async {
        emit(TaskLoading());
        Task updatedTask = await localTaskRepository.updateTask(event.task);
        if (event.isTimeUpdated) {
          await notificationService.scheduleNotification(updatedTask);
        }
        final tasks = await localTaskRepository.getTasks();
        emit(TaskLoaded(tasks: tasks));
        print(state as TaskLoaded);
      },
    );

    on<DeleteTask>(
      (event, emit) async {
        await localTaskRepository.deleteTask(event.task);
      },
    );
  }
}
