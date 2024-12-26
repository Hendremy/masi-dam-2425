import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plant_id/plant_id_view.dart';
import 'package:masi_dam_2425/plants/widgets/plant_tile.dart';
import 'package:masi_dam_2425/plants/widgets/new_plant_tile.dart';

class PlantsPage extends StatelessWidget {
  const PlantsPage({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'PlantsPage',
      key: const ValueKey('PlantsPage'),
      child: const PlantsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Plants')),
      floatingActionButton: FloatingActionButton(
          key: const Key('register_plant_button'),
          onPressed: () {
            //open the plant_id_view page
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PlantIdView()));
          },
          child: const Icon(Icons.add)),
      body: BlocProvider<PlantsBloc>(
          create: (context) => PlantsBloc(
            api: context.read<UserApiServices>().plantsApi,
          ),
        child: BlocBuilder<PlantsBloc, PlantsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            } else {
              if (state.plants.isEmpty) {
                return const Center(
                  child: Text('No plants added yet'),
                );
              } else {
                return Column(
                  children: [
                    ...state.plants
                        .map((Plant plant) => NewPlantTile(plant: plant,))
                        .toList(),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
