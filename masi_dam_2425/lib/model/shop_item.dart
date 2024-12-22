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

  
  static ShopItemType convertType(String type) {
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

  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: convertType(json['type']),
      buffValue: json['buffValue'],
      cost: json['cost'],
      image: json['image'],
    );
  }

  static String toJson(ShopItem item) {
    return item.id;
  }

}

enum ShopItemType { potion, tools, knowledge, unknown }
