class Inventory {
  late int coins;
  late List<Item> items;

  Inventory(
    {
      required this.coins,
      required this.items
    } 
  );

  Inventory.fromMap(Map<String, dynamic> map){
    coins = map['coins'];
    items = [];
    List<dynamic> itemsArray = map['items'];
    for(Map<String, dynamic> itemMap in itemsArray){
      items.add(Item.fromMap(itemMap));
    }
  }
}

class Item {
  late String name;
  late String id;
  late ItemType type;

Item.fromMap(Map<String, dynamic> map){
    name = map['name'];
    type = map['type'];
    id = map['id'];
  }
}

enum ItemType{
  shield, weapon, helmet
}