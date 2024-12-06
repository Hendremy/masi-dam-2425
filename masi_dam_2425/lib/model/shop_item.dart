class ShopItem {
  late String id;
  late String name;
  late String description;
  late ShopItemType type; // "Health", "Growth", or "Knowledge"
  late int buffValue;
  late int cost;
  late String image;

  ShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.buffValue,
    required this.image,
    required this.cost,
  });

  ShopItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    type = convertType(map['type']);
    buffValue = map['buffValue'];
    image = map['image'];
    cost = map['cost'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'buffValue': buffValue,
      'image': image,
      'cost': cost,
    };
  }

  ShopItemType convertType(String type) {
    switch (type) {
      case 'potion':
        return ShopItemType.potion;
      case 'tools':
        return ShopItemType.tools;
      case 'knowledge':
        return ShopItemType.knowledge;
      default:
        return ShopItemType.unknown;
    }
  }
}

enum ShopItemType { potion, tools, knowledge, unknown }
