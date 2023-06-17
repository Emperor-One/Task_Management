import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../models/models.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Addis_Ababa'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/clock');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      // final String? payload = notificationResponse.payload;
      // if (notificationResponse.payload != null) {
      //   debugPrint('notification payload: $payload');
    });
  }

  Future<void> scheduleNotification(Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        "You have a task scheduled to begin soon: ${task.title}",
        task.notes,
        tz.TZDateTime.from(task.startTime!.subtract(const Duration(minutes: 10)), tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'scheduled channel id', 'scheduled channel name',
              channelDescription: 'scheduled channel description',
              importance: Importance.max,
              priority: Priority.high),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
