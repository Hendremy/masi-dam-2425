import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plants/widgets/hp_bar.dart';
import 'package:masi_dam_2425/plants/widgets/xp_bar.dart';

class PlantDetailPage extends StatelessWidget{

  final Plant plant;
  
  PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image plantImg = Image.network(plant.imgUrl);
    Image mood = Image.asset(plant.moodImgPath, width: 100, height: 100);
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  plantImg,
                  mood,
                ],
              ),
              Text('Level: ${plant.level}'),
              HPBar(currentHP: plant.hp.round(), maxHP: 100),
              XPBar(currentXP: plant.xp.round(), maxXP: 100),
              TextButton.icon(onPressed: 
                () {}, 
                label: const Text('Water'),
                icon: const Icon(Icons.water_drop),
              ),
              TextButton.icon(onPressed:
                () {}, 
                label: const Text('Feed'),
                icon: const Icon(Icons.volunteer_activism),
              ),
            ],
          ),
        ),
      ),
    );
  }

}