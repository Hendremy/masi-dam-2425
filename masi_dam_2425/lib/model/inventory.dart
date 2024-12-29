import 'package:masi_dam_2425/exceptions/already_in_possession_exception.dart';
import 'package:masi_dam_2425/exceptions/insufficient_funds_exception .dart';
import 'package:masi_dam_2425/model/shop_item.dart';

class Inventory {
  late int coins;
  late Map<ShopItem, bool> items; // true if item is equipped

  Inventory({required this.coins, required this.items});

  Inventory.empty() {
    coins = 30;
    items = {};
  }

  void add(ShopItem item) {
    if (items.containsKey(item)) {
      throw AlreadyInPossessionException("Item already in your possession!");
    }
    if (!canBuy(item.cost)) {
      throw InsufficientFundsException("Not enough coins!");
    }
    coins -= item.cost;
    items[item] = true;
  }

  bool canBuy(int cost) => cost <= this.coins;

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
