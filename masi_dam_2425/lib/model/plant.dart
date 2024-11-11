class Plant {
  final String name;
  final double xp;
  final double hp;
  final int level;
  late final PlantMood mood;

  Plant({
    required this.name,
    required this.level, 
    required this.xp,
    required this.hp}){
      if(hp >= 70){
        mood = PlantMood.happy;
      }else if(hp >= 30){
        mood = PlantMood.sad;
      }else{
        mood = PlantMood.dead;
      }
    }
}

enum PlantMood{
  happy,
  sad,
  dead
}