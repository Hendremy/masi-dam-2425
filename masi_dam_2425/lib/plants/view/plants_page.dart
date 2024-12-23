import 'package:flutter/material.dart';
import 'package:masi_dam_2425/plant_id/plant_id_view.dart';

class PlantsPage extends StatelessWidget{
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
        key: const Key('homePage_increment_floatingActionButton'),
        onPressed: () {
          //open the plant_id_view page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlantIdView()));
        },
      child: const Icon(Icons.add)),
      body: const Column(
        children: [
          ],
      ),
    );
  }
  
}