import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:masi_dam_2425/permission_service.dart';
class NotificationService {

  NotificationService._() {
    _initialize();
  }

  static final NotificationService _instance = NotificationService._();

  static NotificationService get instance => _instance;

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> _initialize() async {
      const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    await PermissionService.requestNotificationPermission();

      const androidNotificationDetails = AndroidNotificationDetails(
        'local_notifications',
        'Local Notifications',
        importance: Importance.high,
        priority: Priority.high,
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      );

      const notificationDetails = NotificationDetails(android: androidNotificationDetails);

      await _flutterLocalNotificationsPlugin.show(
        0,    // Notification ID
        title, // Notification title
        body,  // Notification body
        notificationDetails,
      );
    }
}