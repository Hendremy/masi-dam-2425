import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';

import '../model/inventory.dart';

class InventoryFirestoreApi extends FirestoreApi implements InventoryApi {
  final ShopApi shopApi;

  final _inventoryController = StreamController<Inventory>.broadcast();
  Stream<Inventory> get inventoryStream => _inventoryController.stream;

  InventoryFirestoreApi({required super.db, required super.storage, required this.shopApi});

  Future<void> loadInventory() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user');
      }

      final document = db.collection('inventory').doc(user.uid);
      final snapshot = await document.get();

      if (snapshot.exists) {
        final data = snapshot.data()!;
        final ids = [];
        final equippedItems = Set<String>();
        Map items = data['items'];
        if (!items.isEmpty) {

          items.keys.forEach((key) {
            ids.add(key as String);
            if (items[key] == true) {
              equippedItems.add(key);
            }
          });
          final shopItems = await shopApi.getItemsByIds(ids.cast<String>());
          data['items'] = Map.fromIterable(
            shopItems,
            key: (item) => item,
            value: (item) => equippedItems.contains(item['id']),
          );
        }
        _inventoryController.add(Inventory.fromJson(data));
      } else {
        await setEmptyInventory(document);
      }
    } catch (e) {
      _inventoryController.addError(e);
    }
  }
  
  @override
  Future<void> setEmptyInventory(document) async {
    final inventory = Inventory.empty();
    final json = inventory.toJson();
    await document.set(json);
    _inventoryController.add(inventory);
  }

  @override
  updateInventory(Inventory updatedProducts) {
    final user = FirebaseAuth.instance.currentUser;
    final document = db.collection('inventory').doc(user!.uid);
    final json = updatedProducts.toJson();
    document.set(json);
    _inventoryController.add(updatedProducts);
  }

  @override
  Future<void> deleteInventory(String uid) {
    final document = db.collection('inventory').doc(uid);
    return document.delete();
  }

}
