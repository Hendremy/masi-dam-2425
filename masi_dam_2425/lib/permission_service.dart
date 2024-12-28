import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  static Future<void> requestLocationPermission() async {
    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }
  }

  static Future<void> requestCameraPermission() async {
    if (await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

}

