import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'todays_tasks.dart';
import 'widgets.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
