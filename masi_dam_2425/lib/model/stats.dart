class Stats {
  late int level;
  late double xp;
  late int healthBoost;
  late double growthMultiplier;

  Stats({
    required this.level,
    required this.xp,
    this.healthBoost = 0,
    this.growthMultiplier = 1.0,
  });

  Stats.fromMap(Map<String, dynamic> map) {
    level = (map['level'] as num).toInt();
    xp = (map['xp'] as num).toDouble();
    healthBoost = (map['healthBoost'] as num).toInt();
    growthMultiplier = (map['growthMultiplier'] as num).toDouble();
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'xp': xp,
      'healthBoost': healthBoost,
      'growthMultiplier': growthMultiplier,
    };
  }

  Stats.starter() {
    level = 1;
    xp = 0;
    healthBoost = 0;
    growthMultiplier = 1.0;
  }
}
