import 'package:masi_dam_2425/model/shop_item.dart';

class ShopItemAssembler {
  static ShopItem fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: ShopItem.convertType(json['type']),
      buffValue: json['buffValue'],
      image: json['image'],
      cost: json['cost'],
    );
  }

  static String toJson(ShopItem shopItem) {
    return shopItem.id;
  }
}
