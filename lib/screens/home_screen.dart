import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                context.push("/TodaysTasksScreen");
              },
              child: Text("Go To Today's tasks")),
        ),
      ),
    );
  }
}
