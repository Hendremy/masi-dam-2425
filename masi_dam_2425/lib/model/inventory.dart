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
    items[item] = true;
  }
}
