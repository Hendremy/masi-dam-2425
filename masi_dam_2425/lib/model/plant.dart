import 'dart:io';
import 'dart:math';

import 'package:uuid/uuid.dart';

class Plant {
  late String uuid;
  late String name;
  late double xp;
  late double maxHp;
  late double growth;
  late String species;
  late String imgUrl;
  late DateTime lastWatered;
  // late DateTime lastFertilized;
  late DateTime dateAdded;
  late int waterInterval;

  late String moodPath;
  // late int fertilizerInterval;

  Plant({
    required this.uuid,
    required this.name,
    required this.species,
    required this.xp,
    required this.imgUrl,
    this.waterInterval = 7,
    required this.lastWatered
    // required this.fertilizerInterval
    });

  PlantMood get mood {
    PlantMood plantMood;
    if (hp >= 90){
      plantMood = PlantMood.veryHappy;
    }else if (hp >= 70) {
      plantMood = PlantMood.happy;
    } else if (hp >= 30) {
      plantMood = PlantMood.angry;
    } else {
      plantMood = PlantMood.dead;
    }
    return plantMood;
  }

  Plant.fromMap(Map<String, dynamic> map){
    uuid = map['uuid'];
    name = map['name'];
    xp = (map['xp'] as num).toDouble();
    species = map['species'];
    imgUrl = map['imgUrl'];
    lastWatered = DateTime.parse(map['lastWatered']);
    waterInterval = map['waterInterval'];
    dateAdded = DateTime.parse(map['dateAdded']);
  }

  Plant.empty(){
    uuid = Uuid().v4();
    name = 'New Plant';
    xp = 0;
    species = 'unknown';
    imgUrl = '';
    lastWatered = DateTime.now();
    waterInterval = 7;
    dateAdded = DateTime.now();
    // lastFertilized = DateTime.now();
    // fertilizerInterval = 30;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'xp': xp,
      'species': species,
      'uuid': uuid,
      'imgUrl': imgUrl,
      'lastWatered': lastWatered.toIso8601String(),
      'waterInterval': waterInterval,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  bool isFullyGrown() => growth >= 100;

  String get moodImgPath{
      Random random = new Random();
      int imgNum;
      String imgMood;
      String imgPath = 'assets/faces/';

      switch(mood){
        case PlantMood.veryHappy:
          imgNum = 3;
          imgMood = 'veryhappy';
        case PlantMood.angry:
          imgNum = 5;
          imgMood = 'angry';
        case PlantMood.dead:
          imgNum = 2;
          imgMood = 'dead';
        default:
          imgNum = 8;
          imgMood = 'happy';
      }
      imgNum = random.nextInt(imgNum) + 1;
      return imgPath + imgMood + '_' + imgNum.toString() + '.png';
    }

  double giveWater(){
    DateTime now = DateTime.now();
    int daysSinceLastWatered = now.difference(lastWatered).inDays;
    double xp_multiplier = daysSinceLastWatered.toDouble() / waterInterval;
    double xp_gain = 50 * xp_multiplier;
    xp += xp_gain;
    lastWatered = now;
    return xp_gain;
  }

  double get hp{
    DateTime now = DateTime.now();
    int daysSinceLastWatered = now.difference(lastWatered).inDays;
    if (daysSinceLastWatered < waterInterval){
      return 100.0;
    }else{
      // TODO: Adjust formula to real plant surivavility
      // Lose 3^x HP for each x day past the water interval
      double updatedHp = 100.0 - (3 ^ (daysSinceLastWatered - waterInterval));
      return updatedHp > 0 ? updatedHp : 0;
    }
  }

  int get level{//TODO : Maybe do scaling level caps, not always 100
    return (xp / 100).round();
  }

  double get remainingXP{
    return xp % 100;
  }

  DateTime get nextWatering{
    return lastWatered.add(Duration(days: waterInterval));
  }

}

enum PlantMood { veryHappy, happy, angry, dead }
