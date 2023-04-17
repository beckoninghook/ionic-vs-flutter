import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showNotification();
      },
      child: Text('Create Notification'),
    );
  }

  Future<void> _showNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // Initialize the plugin
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Define the notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Create the notification
    await flutterLocalNotificationsPlugin.show(10, 'New Notification',
        'This is a notification', platformChannelSpecifics);
  }
}
