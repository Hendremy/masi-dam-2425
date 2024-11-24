import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/bloc/inventory_bloc.dart';
import 'package:masi_dam_2425/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/view/components/experience_bar.dart';
import 'package:masi_dam_2425/view/components/plant_tile.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Center(child: Text('Greenmon')),
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
        ));
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
                      Navigator.pushNamed(context, '/settings');
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
              Navigator.pushNamed(context, '/shop');
            },
            icon: const Icon(Icons.currency_exchange),
            label: Text('${state.inventory != null ? state.inventory!.coins : 0} Coins')),
        TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/inventory');
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
                  Navigator.pushNamed(context, '/plants');
                },
                child: const Text('Plants')),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        ...state.plants.map((Plant plant) => PlantTile(plant))
      ],
    );
  }
}
