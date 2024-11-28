class Profile {
  late String name;
  late String title;
  late int level;
  late double xp;

  Profile(
    {
      required this.name,
      required this.title,
      required this.level,
      required this.xp
    } 
  );

  Profile.fromMap(Map<String, dynamic> map){
    name = map['name'];
    title = map['title'];
    level = (map['level'] as num).toInt();
    xp = (map['xp'] as num).toDouble();
  }

  Profile.empty(){
    name = 'New User';
    title = 'Nobody';
    level = 1;
    xp = 0;
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'title': title,
      'level': level,
      'xp': xp,
    };
  }
}