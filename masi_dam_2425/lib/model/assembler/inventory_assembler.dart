import 'package:masi_dam_2425/model/assembler/shop_item_assembler.dart';
import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

class InventoryAssembler {
  static Inventory fromJson(Map<String, dynamic> json) {
    Map<ShopItem, bool> itemsObject = {};
    final items = json['items'];
    json['items']?.forEach((key, value) {
      itemsObject[ShopItemAssembler.fromJson(key)] = value;
    });
    return Inventory(
      coins: json['coins'] ?? 0,
      items: itemsObject
    );
  }

  static Map<String, dynamic> toJson(Inventory inventory) {
    Map<String, bool> itemsObject = {};
    inventory.items.forEach((key, value) {
      itemsObject[ShopItemAssembler.toJson(key)] = value;
    });
    return {
      'coins': inventory.coins,
      'items': itemsObject
    };
  }
}
