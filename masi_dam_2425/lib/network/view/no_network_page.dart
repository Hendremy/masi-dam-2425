import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoNetworkPage extends StatelessWidget {
  const NoNetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning_rounded,
            color: Colors.green,
            size: 50.0,
          ),
          Text('No internet connection. Please turn on internet.'),
        ],
      ),
    );
  }
}
