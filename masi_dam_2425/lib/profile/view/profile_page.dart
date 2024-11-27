import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{

  const ProfilePage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'ProfilePage',
      key: const ValueKey('ProfilePage'),
      child: const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Profile')),
        
      body: const Column(
        children: [
        ],
      )
    );
  }

}