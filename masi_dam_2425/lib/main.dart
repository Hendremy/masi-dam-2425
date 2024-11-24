import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/firebase_options.dart';
import 'package:masi_dam_2425/home/view/home_page.dart';
import 'package:masi_dam_2425/view/calendar_page.dart';
import 'package:masi_dam_2425/view/inventory_page.dart';
import 'package:masi_dam_2425/view/plants_page.dart';
import 'package:masi_dam_2425/view/shop_page.dart';
import 'package:masi_dam_2425/view/welcome_page.dart';
import 'package:masi_dam_2425/widget_tree.dart';
import 'package:masi_dam_2425/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App(authenticationRepository: authenticationRepository));
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenMon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetTree(),
      routes: {
        '/home': (context) => WelcomePage(),
        '/plants': (context) => PlantsPage(),
        '/shop': (context) => ShopPage(),
        '/settings': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/inventory': (context) => InventoryPage()
      },
    );
  }
  

}
