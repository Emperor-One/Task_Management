import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/home_screen.dart';

import '../bloc/task_bloc.dart';
import '../models/models.dart';

const Color primaryColor = Color.fromRGBO(100, 111, 212, 100);
const Color scaffoldColor = Color.fromRGBO(100, 111, 212, 1);
const Color primaryTextColor = Color(0xFF363636);
const Color secondaryTextColor = Color(0xFF888888);

class ToDoWidget extends StatelessWidget {
  final Task task;
  final double containerWidth;

  const ToDoWidget(
      {required this.task, required this.containerWidth, super.key});

  @override
  Widget build(BuildContext context) {
    List<String> dropDownActions = [
      "Mark Important",
      "Add SubTasks",
      "Edit Tasks",
    ];
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        height: 100,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: SizedBox(
                width: containerWidth * 0.16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        Task.dateString(task.startTime),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      Task.timeString(task.startTime),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      Task.timeString(task.stopTime),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            Checkbox(
              value: task.isDone,
              onChanged: (value) {
                task.isDone = !task.isDone;
                if (task.isDone) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Task marked done!"),
                      duration: Duration(seconds: 10),
                    ),
                  );
                }
                context
                    .read<TaskBloc>()
                    .add(UpdateTask(task: task, isTimeUpdated: false));
              },
              shape: const CircleBorder(),
            ),
            SizedBox(
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Flexible(
                    child: Text(
                      task.notes ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) {
                  return dropDownActions.map((action) {
                    return PopupMenuItem(
                      value: action,
                      child: Text(action),
                    );
                  }).toList();
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Color(0xFF888888),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoneTasksBanner extends StatelessWidget {
  final double width;
  final VoidCallback onTap;
  final bool pressed;
  final int doneTasksCount;
  const DoneTasksBanner(
      {required this.doneTasksCount,
      required this.width,
      required this.onTap,
      this.pressed = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              width: width,
              child: Builder(builder: (context) {
                return (!pressed)
                    ? const Divider(
                        height: 5,
                        thickness: 2,
                        color: secondaryTextColor,
                      )
                    : const Divider(
                        height: 5,
                        thickness: 2,
                        color: Colors.transparent,
                      );
              }),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Done Tasks ($doneTasksCount)",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Builder(builder: (context) {
                  return (!pressed)
                      ? const Icon(
                          Icons.chevron_right,
                          size: 30.0,
                        )
                      : const Icon(
                          Icons.expand_more,
                          size: 30.0,
                        );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToDoList extends StatelessWidget {
  final double width;
  final double height;
  final List<Task> tasks;
  const ToDoList(
      {required this.width,
      required this.height,
      required this.tasks,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
                key: Key(tasks[index].id!.toString()),
                onDismissed: (direction) {
                  context.read<TaskBloc>().add(DeleteTask(task: tasks[index]));
                },
                child: ToDoWidget(task: tasks[index], containerWidth: width));
          },
        ),
      ),
    );
  }
}

class CreateTasksDialog extends StatefulWidget {
  const CreateTasksDialog({super.key});

  @override
  State<CreateTasksDialog> createState() => _CreateTasksDialogState();
}

class _CreateTasksDialogState extends State<CreateTasksDialog> {
  final title = TextEditingController();
  final notes = TextEditingController();
  final startTime = TextEditingController();
  final stopTime = TextEditingController();
  final date = TextEditingController();
  bool isTitleValid = false;
  bool isImportantPressed = false;

  @override
  void dispose() {
    title.dispose();
    notes.dispose();
    startTime.dispose();
    stopTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Row(
        children: [
          SizedBox(
            width: dialogWidth * 0.6,
            child: TextField(
              controller: title,
              decoration: const InputDecoration(hintText: "Task Title"),
              onChanged: (value) {
                setState(() {
                  isTitleValid = value.isNotEmpty;
                });
              },
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  isImportantPressed = !isImportantPressed;
                });
              },
              child: (isImportantPressed)
                  ? Icon(
                      Icons.star_outlined,
                      color: Colors.amber,
                    )
                  : Icon(Icons.star_border))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17.7),
      ),
      content: SingleChildScrollView(
          child: Column(
        children: [
          TextField(
            controller: notes,
            decoration:
                const InputDecoration(hintText: "(Optional) Description"),
          ),
          TextField(
            controller: date,
            decoration: const InputDecoration(
                hintText: "(Optional) Date in yyyy-mm-dd"),
          ),
          TextField(
            controller: startTime,
            decoration: const InputDecoration(
                hintText: "(Optional) Start Time 24-hour format"),
          ),
          TextField(
            controller: stopTime,
            decoration: const InputDecoration(
                hintText: "(Optional) Stop Time 24-hour format"),
          ),
          ElevatedButton(
              onPressed: (isTitleValid)
                  ? () {
                      DateTime? startTimeDateTime =
                          Task.toDateTime(startTime.text, date.text);
                      DateTime? stopTimeDateTime =
                          Task.toDateTime(stopTime.text, date.text);
                      Task newTask = Task(
                        title: title.text,
                        notes: notes.text,
                        startTime: startTimeDateTime,
                        stopTime: stopTimeDateTime,
                        isDone: false,
                        isImportant: isImportantPressed,
                        category: "Optional Category",
                      );
                      context.read<TaskBloc>().add(CreateTask(task: newTask));
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text("Create Task"))
        ],
      )),
    );
  }
}

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: scaffoldColor,
  appBarTheme: const AppBarTheme(
    toolbarHeight: 75,
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontFamily: "Jost",
      fontWeight: FontWeight.w500,
      fontSize: 25,
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
        fontFamily: "Signika",
        fontWeight: FontWeight.w300,
        fontSize: 14,
        color: secondaryTextColor,
        overflow: TextOverflow.ellipsis),
    bodyMedium: TextStyle(
      fontFamily: "Signika",
      fontWeight: FontWeight.w300,
      fontSize: 20,
      color: primaryTextColor,
    ),
    labelSmall: TextStyle(
        fontFamily: "Signika",
        fontWeight: FontWeight.w300,
        fontSize: 8,
        color: secondaryTextColor,
        overflow: TextOverflow.ellipsis),
    labelMedium: TextStyle(
      fontFamily: "Jost",
      fontSize: 18,
    ),
  ),
);
