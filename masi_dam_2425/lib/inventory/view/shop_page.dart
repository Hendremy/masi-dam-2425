import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShopPage extends StatelessWidget{
  const ShopPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'ShopPage',
      key: const ValueKey('ShopPage'),
      child: const ShopPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Shop')),
        
      body: const Column(
        children: [
        ],
      )
    );
  }

}