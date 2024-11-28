import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/app/bloc/app_bloc.dart';
import 'package:masi_dam_2425/home/bloc/inventory_bloc.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/home/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/inventory/view/inventory_page.dart';
import 'package:masi_dam_2425/inventory/view/shop_page.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plants/view/calendar_page.dart';
import 'package:masi_dam_2425/plants/view/plants_page.dart';
import 'package:masi_dam_2425/plants/widgets/experience_bar.dart';
import 'package:masi_dam_2425/plants/widgets/plant_tile.dart';
import 'package:masi_dam_2425/profile/view/profile_page.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: WelcomePage());

  @override
  Widget build(BuildContext context) {
    return Provider<UserApiServices>(
      create: (BuildContext context) => UserApiServices(firestoreDb: FirebaseFirestore.instance),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(api: context.read<UserApiServices>().profileApi),),
          BlocProvider<InventoryBloc>(
            create: (BuildContext context) => InventoryBloc(api: context.read<UserApiServices>().inventoryApi)),
          BlocProvider<PlantsBloc>(
            create: (BuildContext context) => PlantsBloc(api: context.read<UserApiServices>().plantsApi))
            ],
        child: Scaffold(
            appBar: AppBar(
            title: const Text('Home'),
            actions: <Widget>[
              IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<AppBloc>().add(const AppLogoutPressed());
                },
              ),
            ],
          ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return state.isLoading ? const CircularProgressIndicator() : _profileRow(context, state);
                    },
                  ),
                  BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                      return state.isLoading ? const CircularProgressIndicator() : _shopRow(context, state);
                    },
                  ),
                  BlocBuilder<PlantsBloc, PlantsState>(
                    builder: (context, state) {
                      return state.isLoading ? const CircularProgressIndicator() : _plantsColumn(context, state);
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _profileRow(context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/warrior.jpg',
          height: 100,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(state.profile != null ? state.profile.name : 'User'),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            Text(state.profile != null ? state.profile.title : 'Nobody'),
            _levelRow(context, state)
          ],
        )
      ],
    );
  }

  Widget _levelRow(context, ProfileState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Lvl ${state.profile != null ? state.profile!.level : 1}'),
        ExperienceBar(
          currentXp: state.profile != null ? state.profile!.xp : 0,
          maxXp: 100,
          color: Colors.blue,
        )
      ],
    );
  }

  Widget _shopRow(context, InventoryState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopPage()));
            },
            icon: const Icon(Icons.currency_exchange),
            label: Text('${state.inventory != null ? state.inventory!.coins : 0} Coins')),
        TextButton.icon(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InventoryPage()));
            },
            icon: const Icon(Icons.backpack),
            label: const Text("Inventory")),
      ],
    );
  }

  Widget _plantsColumn(context, PlantsState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlantsPage()));
                },
                child: const Text('Plants')),
            IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()));;
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        ...state.plants.map((Plant plant) => PlantTile(plant))
      ],
    );
  }
}
