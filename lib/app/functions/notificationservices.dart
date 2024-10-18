import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationManager {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    print('ins!@#@!#!@#!@#@!@!@!anager');
    _notification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings()));

    tz.initializeTimeZones();
  }

  static scheduledNotification(String title, String body) async {
    var androidDetails = const AndroidNotificationDetails(
        'important_notificaitons', 'My Channel',
        importance: Importance.max, priority: Priority.high);

    var notificationDetails = NotificationDetails(android: androidDetails);

    await _notification.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
}
