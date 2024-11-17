import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/bloc/inventory_bloc.dart';
import 'package:masi_dam_2425/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/model/auth.dart';
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
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProfileBloc>(
                create: (BuildContext context) => ProfileBloc(),
              ),
              BlocProvider<InventoryBloc>(create: (BuildContext context) => InventoryBloc()),
              BlocProvider<PlantsBloc>(create: (BuildContext context) => PlantsBloc())],
            child: WelcomePage());
        } else {
          return const LoginPage();
        }
      }
      );
  }
  
}