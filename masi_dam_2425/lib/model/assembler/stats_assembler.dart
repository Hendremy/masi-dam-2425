import 'package:masi_dam_2425/model/stats.dart';

class StatsAssembler {
  static Stats fromJson(Map<String, dynamic> json) {
    return Stats(
      growthMultiplier: json['growthMultiplier'],
      healthBoost: json['healthBoost'],
      level: json['level'],
      xp: json['xp'],
    );
  }

  static Map<String, dynamic> toJson(Stats stats) {
    return {
      'growthMultiplier': stats.growthMultiplier,
      'healthBoost': stats.healthBoost,
      'level': stats.level,
      'xp': stats.xp,
    };
  }
}