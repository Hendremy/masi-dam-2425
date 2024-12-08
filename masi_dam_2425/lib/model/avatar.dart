import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/model/stats.dart';

class Avatar {
  late String name;
  late String title;
  late Stats stats;
  late Inventory inventory;

  Avatar({
    required this.name,
    required this.title,
    required this.stats,
    required this.inventory,
  });

  Avatar.starter(String? name, String? email) {
    this.name = name ?? 'Player';
    title = 'Baby warrior';
    stats = Stats.starter();
    inventory = Inventory.empty();
  }

  Avatar.empty() {
    name = 'User';
    title = 'Nobody';
    stats = Stats.starter();
    inventory = Inventory.empty();
  }

  get level => stats.level;

  get xp => stats.xp;

  get coins => inventory.coins;

  copyWith({
    String? name,
    String? title,
    Stats? stats,
    Inventory? inventory,
  }) {
    return Avatar(
      name: name ?? this.name,
      title: title ?? this.title,
      stats: stats ?? this.stats,
      inventory: inventory ?? this.inventory,
    );
  }

  void buy(ShopItem item) {
    inventory.coins -= item.cost;
    inventory.add(item);
  }

  canBuy(ShopItem? shopItem) {
    return shopItem != null && shopItem.cost <= coins;
  }
}
