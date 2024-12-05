class Inventory {
  late int coins;
  late List<Item> items;

  Inventory({required this.coins, required this.items});

  Inventory.fromMap(Map<String, dynamic> map) {
    coins = (map['coins'] as num).toInt();
    items = [];
    List<dynamic> itemsArray = map['items'];
    for (Map<String, dynamic> itemMap in itemsArray) {
      items.add(Item.fromMap(itemMap));
    }
  }

  Inventory.empty() {
    coins = 0;
    items = [];
  }

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> itemsMap = [];
    for (Item item in items) {
      itemsMap.add(item.toMap());
    }
    return {
      'coins': coins,
      'items': itemsMap,
    };
  }

  void add(Item item) {}
}

class Item {
  late String name;
  late String id;
  late ItemType type;
  late String description;
  late bool isEquipped;
  late int cost;

  Item({
    required this.name,
    required this.id,
    required this.type,
    required this.description,
    required this.cost,
  });

  Item.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    id = map['id'];
    type = convertType(map['type']);
    description = map['description'];
    cost = map['cost'];
    isEquipped = true;
  }

  ItemType convertType(String type) {
    return switch (type) {
      'potion' => ItemType.potion,
      'tools' => ItemType.tools,
      'knowledge' => ItemType.knowledge,
      String() => ItemType.unknown,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'type': type.toString().split('.').last,
      'description': description,
      'cost': cost,
    };
  }
}

enum ItemType { potion, tools, knowledge, unknown }
