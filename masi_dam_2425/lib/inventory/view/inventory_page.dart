import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InventoryPage extends StatelessWidget{

  const InventoryPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'InventoryPage',
      key: const ValueKey('InventoryPage'),
      child: const InventoryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Inventory')),
      body: const Column(
        children: [
        ],
      )
    );
  }

}