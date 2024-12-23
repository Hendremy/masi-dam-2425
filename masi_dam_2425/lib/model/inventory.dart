import 'package:masi_dam_2425/model/shop_item.dart';

class Inventory {
  late int coins;
  late Map<ShopItem, bool> items; // true if item is equipped

  Inventory({required this.coins, required this.items});

  Inventory.empty() {
    coins = 0;
    items = {};
  }

  void add(ShopItem item) {
    coins -= item.cost;
    items[item] = true;
  }

  factory Inventory.fromJson(Map<String, dynamic> json) {
    Map<ShopItem, bool> itemsObject = {};
    json['items']?.forEach((key, value) {
      itemsObject[ShopItem.fromJson(key)] = value;
    });
    return Inventory(
        coins: json['coins'] ?? 0,
        items: itemsObject
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, bool> itemsObject = {};
    items.forEach((key, value) {
      itemsObject[ShopItem.toJson(key)] = value;
    });
    return {
      'coins': coins,
      'items': itemsObject
    };
  }

  toggleItem(ShopItem item) {
    items[item] = !items[item]!;
  }

}
