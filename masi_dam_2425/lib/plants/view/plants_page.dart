import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlantsPage extends StatelessWidget{
  const PlantsPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'PlantsPage',
      key: const ValueKey('PlantsPage'),
      child: const PlantsPage(),
    );
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Plants')),
      body: const Column(
        children: [
          ],
      ),
    );
  }
  
}