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

  Stats.starter() {
    level = 1;
    xp = 0;
    healthBoost = 0;
    growthMultiplier = 1.0;
  }

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      level: json['level'],
      xp: json['xp'],
      healthBoost: json['healthBoost'],
      growthMultiplier: json['growthMultiplier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'xp': xp,
      'healthBoost': healthBoost,
      'growthMultiplier': growthMultiplier,
    };
  }
}
