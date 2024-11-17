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
    level = map['level'];
    xp = map['xp'];
  }
}