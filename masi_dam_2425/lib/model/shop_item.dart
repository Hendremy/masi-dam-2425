

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShopItem && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ cost.hashCode;

}

enum ShopItemType {
  potion, tools, knowledge, unknown;

  String getImageAsset() {
    switch (this) {
      case ShopItemType.potion:
        return 'https://firebasestorage.googleapis.com/v0/b/hepl-masi5-flutter.firebasestorage.app/o/assets%2Fitems%2Fred-potion.png?alt=media&token=f0d9e27d-4785-4649-a317-ba5a0ea8e969';
      case ShopItemType.tools:
        return 'https://firebasestorage.googleapis.com/v0/b/hepl-masi5-flutter.firebasestorage.app/o/assets%2Fitems%2Ftool.png?alt=media&token=085ddd2f-1bc9-48da-898f-fe73f0fb71c4';
      case ShopItemType.knowledge:
        return 'https://firebasestorage.googleapis.com/v0/b/hepl-masi5-flutter.firebasestorage.app/o/assets%2Fitems%2Fknowledge-book.png?alt=media&token=c27e8159-0e3f-4058-a63e-ed2fdacb2b25';
      case ShopItemType.unknown:
        return 'https://firebasestorage.googleapis.com/v0/b/hepl-masi5-flutter.firebasestorage.app/o/assets%2Fitems%2Fenergy.png?alt=media&token=280d571e-dd5f-423a-8818-90afe57e9eea';
      default:
        return '';  // Default image in case something goes wrong
    }
  }

}
