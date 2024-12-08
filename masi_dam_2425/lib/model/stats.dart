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
}
