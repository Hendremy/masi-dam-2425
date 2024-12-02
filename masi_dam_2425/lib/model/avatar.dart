class Avatar {
  late String name;
  late String title;
  late int level;
  late double xp;

  Avatar({
    required this.name,
    required this.title,
    required this.level,
    required this.xp,
  });

  Avatar.fromMap(Map<String, dynamic> map) {
    name = map['name'] ?? 'User';
    title = map['title'] ?? 'Nobody';
    level = (map['level'] as num).toInt();
    xp = (map['xp'] as num).toDouble();
  }

  Avatar.starter(String? name, String? email) {
    this.name = name ?? 'Player';
    title = 'Baby warrior';
    level = 1;
    xp = 0.0;
  }

  Avatar.empty() {
    name = 'User';
    title = 'Nobody';
    level = 1;
    xp = 0.0;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'level': level,
      'xp': xp,
    };
  }

  copyWith({String? displayName}) {
    return Avatar(
      name: displayName ?? this.name,
      title: this.title,
      level: this.level,
      xp: this.xp,
    );
  }
}
