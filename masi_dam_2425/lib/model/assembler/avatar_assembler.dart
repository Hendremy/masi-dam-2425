import 'package:masi_dam_2425/model/assembler/inventory_assembler.dart';
import 'package:masi_dam_2425/model/assembler/stats_assembler.dart';
import 'package:masi_dam_2425/model/avatar.dart';

class AvatarAssembler {
  
  static Avatar fromJson(Map<String, dynamic> json) {
    return Avatar(
      name: json['name'],
      title: json['title'],
      stats: StatsAssembler.fromJson(json['stats']),
      inventory: InventoryAssembler.fromJson(json['inventory']),
    );
  }

  static Map<String, dynamic> toJson(Avatar avatar) {
    return {
      'name': avatar.name,
      'title': avatar.title,
      'stats': StatsAssembler.toJson(avatar.stats)
    };
  }
}
