import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../models/models.dart';
import 'widgets.dart';

class TodaysTasks extends StatefulWidget {
  const TodaysTasks({super.key});

  @override
  State<TodaysTasks> createState() => _TodaysTasksState();
}

class _TodaysTasksState extends State<TodaysTasks> {
  bool donePressed = false;
  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    double containerWidth = MediaQuery.of(context).size.width * 0.91;
    double backArrowPadding = (pageWidth - containerWidth) / 2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: backArrowPadding),
          child: const Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
        title: const Text("Today's Tasks"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: scaffoldColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CreateTasksDialog();
              });
        },
        child: const Icon(
          Icons.add,
          size: 32.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: pageHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              Colors.white,
            ],
          ),
        ),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              List<Task> doneTasksList = state.tasks.where((task) => task.isDone).toList();
              List<Task> tasksList = state.tasks.where((task) => !task.isDone).toList();
              return SizedBox(
                height: pageHeight,
                child: Column(
                  children: [
                    Builder(builder: (context) {
                      return (donePressed)
                          ? const Center(child: SizedBox())
                          : ToDoList(
                              width: containerWidth,
                              height: pageHeight * 0.6,
                              tasks: tasksList,
                            );
                    }),
                    DoneTasksBanner(
                      width: containerWidth,
                      pressed: donePressed,
                      doneTasksCount: doneTasksList.length,
                      onTap: () {
                        setState(() {
                          donePressed = (!donePressed) ? true : false;
                        });
                      },
                    ),
                    Builder(builder: (context) {
                      return (!donePressed)
                          ? const Center(child: SizedBox())
                          : ToDoList(
                              width: containerWidth,
                              height: pageHeight * 0.6,
                              tasks: doneTasksList,
                            );
                    })
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
