import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/plant.dart';

class NewPlantTile extends StatelessWidget {
  late String name;
  late int level;
  late int currentHP;
  late int maxHP;
  late int currentXP;
  late int maxXP;
  late String imgPath;


  NewPlantTile({
    Key? key,
    required Plant plant}) : super(key: key){
      name = plant.name;
      level = plant.level;
      currentHP = plant.hp.round();
      maxHP = 100;
      currentXP = plant.xp.round();
      maxXP = 100;
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

  Color _getHPColor() {
    final percentage = currentHP / maxHP;
    if (percentage > 0.5) return Colors.green;
    if (percentage > 0.2) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pokemon Image and Level Column
          Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Lv$level',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 12),
          
          // Status Information Column
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Row
                Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                // HP Section
                Row(
                  children: [
                    const Text(
                      'HP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: currentHP / maxHP,
                              backgroundColor: Colors.grey[300],
                              color: _getHPColor(),
                              minHeight: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$currentHP/$maxHP',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // XP Bar
                Row(
                  children: [
                    const Text(
                      'EXP',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: currentXP / maxXP,
                              backgroundColor: Colors.grey[300],
                              color: Colors.blue,
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}