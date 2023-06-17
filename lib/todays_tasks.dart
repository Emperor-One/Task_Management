import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    final List<int> tasks = List.generate(1000, (index) => index);
    final List<int> doneTasks = List.generate(2, (index) => index);
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    double containerWidth = MediaQuery.of(context).size.width * 0.91;
    double backArrowPadding = (pageWidth - containerWidth) / 2;
    return Scaffold(
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
        onPressed: () {},
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
        child: SizedBox(
          height: pageHeight,
          child: Column(
            children: [
              Builder(builder: (context) {
                return (donePressed)
                    ? const Center(child: SizedBox())
                    : ToDoList(
                        width: containerWidth,
                        height: pageHeight * 0.6,
                        tasks: tasks,
                      );
              }),
              DoneTasksBanner(
                width: containerWidth,
                pressed: donePressed,
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
                        tasks: doneTasks,
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
