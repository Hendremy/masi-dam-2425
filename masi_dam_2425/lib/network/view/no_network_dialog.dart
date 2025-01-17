import 'package:flutter/material.dart';
class Network {
  static void showNoNetworkDialog(BuildContext context) {
    showGeneralDialog(
              context: context,
              pageBuilder: (context, anim1, anim2) {
                return Container();
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1).animate(anim1),
                    child: FadeTransition(
                      opacity:
                          Tween<double>(begin: 0.5, end: 1.0).animate(anim1),
                      child: AlertDialog(
                        title: Text('No Internet Connection'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Image.asset(
                              'assets/greenmon-logo.png',
                              width: 150,
                            ),
                            SizedBox(height: 16),
                            Text('Please check your internet settings.'),
                          ],
                        ),
                      ),
                    ));
              });
  }
}