import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repositories/local_task_reposiotry.dart';
import '../models/models.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final LocalTaskRepository localTaskRepository;
  TaskBloc({required this.localTaskRepository}) : super(TaskInitial()) {
    on<TaskLoad>((event, emit) async {
      emit(TaskLoading());
      final tasks = await localTaskRepository.getTasks();
      emit(TaskLoaded(tasks: tasks));
    });

    on<CreateTask>(
      (event, emit) async {
        emit(TaskLoading());
        await localTaskRepository.createTask(event.task);
        final tasks = await localTaskRepository.getTasks();
        emit(TaskLoaded(tasks: tasks));
        print(state as TaskLoaded);
      },
    );
  }
}
