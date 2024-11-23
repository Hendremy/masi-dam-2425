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
    xp = (map['xp'] as num).toDouble();
    hp = (map['hp'] as num).toDouble();
  }

  Plant.empty(){
    name = 'New Plant';
    level = 1;
    xp = 0;
    hp = 100;
    species = 'unknown';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'xp': xp,
      'hp': hp,
      'species': species,
    };
  }
}

enum PlantMood{
  happy,
  sad,
  dead
}