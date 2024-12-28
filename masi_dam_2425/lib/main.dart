import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/app/bloc_observer.dart';
import 'package:masi_dam_2425/app/view/app.dart';
import 'package:masi_dam_2425/firebase_options.dart';
import 'package:workmanager/workmanager.dart';

import 'notification_service.dart';

const String backgroundTask = "background_notification_task";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Initialize NotificationService
    final notificationService = NotificationService.instance;

    if (task == "show_notification_task") {
      // Show a notification
      await notificationService.showNotification(
        inputData?["title"],
        inputData?["message"],
      );
    }

    return Future.value(true);
  });
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = const AppBlocObserver();
  // Initialize WorkManager
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Set to false in production
  );

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(App(authenticationRepository: authenticationRepository));
}



