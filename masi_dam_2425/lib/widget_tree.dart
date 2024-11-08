import 'package:flutter/widgets.dart';
import 'package:masi_dam_2425/main.dart';
import 'package:masi_dam_2425/model/auth.dart';
import 'package:masi_dam_2425/view/home_page.dart';
import 'package:masi_dam_2425/view/login_register_page.dart';
import 'package:masi_dam_2425/view/welcome_page.dart';

class WidgetTree extends StatefulWidget {

  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges, 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WelcomePage();
        } else {
          return const LoginPage();
        }
      }
      );
  }
  
}