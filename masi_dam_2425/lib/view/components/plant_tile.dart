import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/view/components/experience_bar.dart';

class PlantTile extends StatelessWidget {
  Plant plant;
  late String imgPath;

  PlantTile(this.plant, {super.key}){
    switch(plant.mood){
      case PlantMood.happy:
        imgPath = 'assets/plant_happy.jpg';
      case PlantMood.sad:
        imgPath = 'assets/plant_sad.png';
      case PlantMood.dead:
        imgPath = 'assets/plant_dead.jpg';
      default:
        imgPath = 'assets/plant_happy.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(imgPath, height: 75,),
        Column(
          children: [
            Text(plant.name),
            Row(
              children: [
                const Text('HP'),
                ExperienceBar(currentXp: plant.xp, maxXp: 100, color: Colors.green),
              ],
            ),
            Row(
              children: [
                const Text('XP'),
                ExperienceBar(currentXp: plant.hp, maxXp: 100, color: Colors.blue),
              ],
            )
          ],
        ),

      ],
    );
  }



}