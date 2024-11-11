import 'dart:io';

class Plant {
  late String name;
  late double xp;
  late double hp;
  late int level;
  late String species;

  Plant({
    required this.name,
    required this.species,
    required this.level, 
    required this.xp,
    required this.hp});

  PlantMood get mood {
    PlantMood plantMood;
    if(hp >= 70){
        plantMood = PlantMood.happy;
      }else if(hp >= 30){
        plantMood = PlantMood.sad;
      }else{
        plantMood = PlantMood.dead;
      }
    return plantMood;
  }

  Plant.fromMap(Map<String, dynamic> map){
    name = map['name'];
    level = map['level'];
    xp = map['xp'];
    hp = map['hp'];
  }
}

enum PlantMood{
  happy,
  sad,
  dead
}