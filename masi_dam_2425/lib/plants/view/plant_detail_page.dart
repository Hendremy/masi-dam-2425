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
                  AspectRatio(
                  aspectRatio: 3/4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(image: plantImg.image, fit: BoxFit.fitWidth),
                      // borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1.5),
                        ),
                      ],
                    )
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 375),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(85, 255, 255, 255),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1.5),
                              ),
                            ],
                          ),
                          child: mood
                          ),
                        SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1.5),
                              ),
                            ],
                          ),
                          child: Text('Lv${plant.level} ${plant.species}'))
                      ],
                    ),
                  ],
                ),
                ]
              ),
              Column(
                children: [
                  // SizedBox(height: 500),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1.5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}