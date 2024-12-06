import 'package:masi_dam_2425/model/shop_item.dart';

class Inventory {
  late int coins;
  late Map<ShopItem, bool> items; // true if item is equipped

  Inventory({required this.coins, required this.items});

  Inventory.fromMap(Map<String, dynamic> map) {
    coins = (map['coins'] as num).toInt();
    items = {};
    List<dynamic> itemsArray = map['items'];
    for (Map<String, dynamic> itemMap in itemsArray) {
      items.putIfAbsent(ShopItem.fromMap(itemMap), () => true);
    }
  }

  Inventory.empty() {
    coins = 0;
    items = {};
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> itemsMap = [];
    for (ShopItem item in items.keys) {
      itemsMap.add(item.toMap());
    }
    return {
      'coins': coins,
      'items': itemsMap,
    };
  }

  void add(ShopItem item) {}
}
