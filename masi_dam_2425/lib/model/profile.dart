import 'package:masi_dam_2425/model/plant.dart';

class Profile {
  late String name;
  late int level;
  late double xp;
  late List<Plant> plants;

  Profile(
    {
      required this.name,
      required this.level, 
      required this.xp,
      required this.plants
    } 
  );

  Profile.fromMap(Map<String, dynamic> map){
    name = map['name'];
    level = map['level'];
    xp = map['xp'];
    plants = map['plants'].map((plant) => Plant.fromMap(plant));
  }
}