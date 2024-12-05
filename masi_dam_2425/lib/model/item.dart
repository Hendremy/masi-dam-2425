class ShopItem {
  final String name;
  final String description;
  final String buffType; // "Health", "Growth", or "Knowledge"
  final int buffValue;
  bool isEquipped;
  final int cost;

  ShopItem({
    required this.name,
    required this.description,
    required this.buffType,
    required this.buffValue,
    this.isEquipped = false,
    required this.cost,
  });
}
