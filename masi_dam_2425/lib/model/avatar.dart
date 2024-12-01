class Avatar {
  late String name;
  late String title;
  late int level;
  late double xp;
  late String email;

  Avatar({
    required this.name,
    required this.title,
    required this.level,
    required this.xp,
    required this.email,
  });

  Avatar.fromMap(Map<String, dynamic> map) {
    name = map['name'] ?? 'User';
    title = map['title'] ?? 'Nobody';
    level = (map['level'] as num).toInt();
    xp = (map['xp'] as num).toDouble();
    email = map['email'] ?? '';
  }

  Avatar.starter(String? name, String? email) {
    this.name = name ?? 'Player';
    this.email = email ?? '';
    title = 'Baby warrior';
    level = 1;
    xp = 0.0;
  }

  Avatar.empty() {
    name = 'User';
    title = 'Nobody';
    level = 1;
    xp = 0.0;
    email = '';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'level': level,
      'xp': xp,
      'email': email,
    };
  }
}
