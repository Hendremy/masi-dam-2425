import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/bloc/profile_bloc.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/model/profile.dart';
import 'package:masi_dam_2425/view/components/experience_bar.dart';
import 'package:masi_dam_2425/view/components/plant_tile.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.green,
                title: Center(child: Text('Greenmon')),
              ),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    _userRow(context, context.read<ProfileBloc>().state),
                    _shopRow(context),
                    _plantsColumn(context)
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget _userRow(context, ProfileState state) {
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
                Text('SuperUser'),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    icon: Icon(Icons.settings))
              ],
            ),
            Text('Guardian of the Plants'),
            _levelRow(context)
          ],
        )
      ],
    );
  }

  Widget _levelRow(context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Lvl 50'),
        ExperienceBar(
          currentXp: 50,
          maxXp: 100,
          color: Colors.blue,
        )
      ],
    );
  }

  Widget _shopRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/shop');
            },
            icon: const Icon(Icons.currency_exchange),
            label: const Text("1500")),
        TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/inventory');
            },
            icon: const Icon(Icons.backpack),
            label: const Text("Inventory")),
      ],
    );
  }

  Widget _plantsColumn(context) {
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
                child: Text('Plants')),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/calendar');
                },
                icon: const Icon(Icons.calendar_month))
          ],
        ),
        PlantTile(Plant(name: 'Raf', species: 'Fern', xp: 20, level: 1, hp: 5)),
        PlantTile(Plant(
            name: 'Gère le fou', species: 'Fern', xp: 30, level: 50, hp: 50)),
        PlantTile(Plant(
            name: 'Belzebulbe', species: 'Fern', xp: 50, level: 99, hp: 75)),
      ],
    );
  }
}
