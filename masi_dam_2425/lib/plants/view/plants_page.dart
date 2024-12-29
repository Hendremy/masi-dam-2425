import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/home/bloc/plants_bloc.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plant_id/plant_camera_view.dart';
import 'package:masi_dam_2425/plants/widgets/new_plant_tile.dart';

class PlantsPage extends StatelessWidget {
  final PlantsBloc plantsBloc;

  const PlantsPage({Key? key, required this.plantsBloc}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: 'CalendarPage',
      key: const ValueKey('CalendarPage'),
      child: Text('TODO : Redo plants page because it breaks bloc heritence and stuff')//const PlantsPage(plantsBloc: ,),
    );
  }

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Plants')),
      floatingActionButton: FloatingActionButton(
          key: const Key('register_plant_button'),
          onPressed: () {
            //open the plant_id_view page
            Navigator.push(
                mainContext,
                MaterialPageRoute(
                    builder: (context) => PlantCameraView(plantBloc: plantsBloc)));
          },
          child: const Icon(Icons.add)),
      body: BlocBuilder<PlantsBloc, PlantsState>(
        bloc: plantsBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          } else {
            if (state.plants.isEmpty) {
              return const Center(
                child: Text('No plants added yet'),
              );
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...state.plants
                        .map((Plant plant) => NewPlantTile(
                              plant: plant,
                            ))
                        .toList(),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
