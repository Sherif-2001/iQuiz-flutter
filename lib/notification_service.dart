// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationServices {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final _androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  void initializeNotifications() async {
    final initializationSettings =
        InitializationSettings(android: _androidInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
      color: Colors.blue,
      colorized: true,
      autoCancel: true,
    );

    final notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
