import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarPage extends StatelessWidget{

  const CalendarPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'CalendarPage',
      key: const ValueKey('CalendarPage'),
      child: const CalendarPage(),
    );
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Watering Calendar')),
      body: const Column(
        children: [
          ],
      ),
    );
  }
  
}