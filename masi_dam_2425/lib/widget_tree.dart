import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/bloc/inventory_bloc.dart';
import 'package:masi_dam_2425/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/model/auth.dart';
import 'package:masi_dam_2425/view/login_register_page.dart';
import 'package:masi_dam_2425/view/welcome_page.dart';
import 'package:provider/provider.dart';

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
          return Provider<UserApiServices>(
            create: (BuildContext context) => UserApiServices(firestoreDb: FirebaseFirestore.instance),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<ProfileBloc>(
                  create: (BuildContext context) => ProfileBloc(api: context.read<UserApiServices>().profileApi),),
                BlocProvider<InventoryBloc>(
                  create: (BuildContext context) => InventoryBloc(api: context.read<UserApiServices>().inventoryApi)),
                BlocProvider<PlantsBloc>(
                  create: (BuildContext context) => PlantsBloc(api: context.read<UserApiServices>().plantsApi))],
              child: WelcomePage()),
          );
        } else {
          return const LoginPage();
        }
      }
      );
  }
  
}