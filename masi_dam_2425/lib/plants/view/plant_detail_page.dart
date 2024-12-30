import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/plant.dart';

class PlantDetailPage extends StatelessWidget{

  final Plant plant;
  
  PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Name: ${plant.name}'),
            Text('Level: ${plant.level}'),
            Text('HP: ${plant.hp.round()}'),
            Text('XP: ${plant.xp.round()}'),
            Text('Mood: ${plant.mood}'),
            Image.asset('assets/plant_happy.jpg'),
          ],
        ),
      ),
    );
  }

}