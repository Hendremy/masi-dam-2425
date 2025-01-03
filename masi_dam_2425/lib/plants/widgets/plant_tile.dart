import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/plants/view/plant_page.dart';
import 'package:masi_dam_2425/plants/widgets/hp_bar.dart';
import 'package:masi_dam_2425/plants/widgets/xp_bar.dart';

class PlantTile extends StatelessWidget {
  final Plant plant;
  late String name;
  late int level;
  late int currentHP;
  late int maxHP;
  late int currentXP;
  late int maxXP;


  PlantTile({
    Key? key,
    required Plant this.plant}) : super(key: key){
      name = plant.name;
      level = plant.level;
      currentHP = plant.hp.round();
      maxHP = 100;
      currentXP = plant.xp.round();
      maxXP = 100;
    }

  @override
  Widget build(BuildContext context) {
    Image plantImg = Image.network(plant.imgUrl);
    return InkWell(
      onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlantDetailPage(plant: plant),
            ),
          );
        },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //border: Border.all(color: Colors.black, width: 2.0),
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
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Image and Level Column
            Column(
              children: [
                Container(
                  width: 80,
                  height: 105,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 80/105,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              image: DecorationImage(image: plantImg.image, fit: BoxFit.cover),
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
                        Column(
                          children: [
                            SizedBox(height: 35),
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
                              child: 
                                Image.asset(
                                  plant.moodImgPath,
                                  fit: BoxFit.contain,
                                ),
                          )],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //   decoration: BoxDecoration(
                //     color: Colors.blue[100],
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Text(
                //     'Lv$level',
                //     style: const TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
            
            const SizedBox(width: 8),
            
            // Status Information Column
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Row
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    plant.species,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),
                  
                  // const SizedBox(height: 8),
                  
                  // HP Bar Container
                  HPBar(currentHP: currentHP, maxHP: maxHP),
                  // XP Bar
                  XPBar(currentXP: plant.remainingXP.round(), maxXP: maxXP, level: level),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}