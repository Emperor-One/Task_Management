import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/task_bloc.dart';
import 'data_providers/local_task_data_provider.dart';
import 'repositories/local_task_reposiotry.dart';
import 'screens/todays_tasks.dart';
import 'screens/widgets.dart';

void main() {
  final LocalTaskRepository localTaskRepository =
      LocalTaskRepository(LocalTaskDataProvider());
  runApp(App(localTaskRepository: localTaskRepository));
}

class App extends StatelessWidget {
  final LocalTaskRepository localTaskRepository;
  const App({required this.localTaskRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: localTaskRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TaskBloc>(
            create: (context) => TaskBloc(localTaskRepository: localTaskRepository)..add(const TaskLoad()))
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: "/",
                builder: (context, state) => const TodaysTasks(),
              ),
            ],
          ),
          theme: appTheme,
        ),
      ),
    );
  }
}
