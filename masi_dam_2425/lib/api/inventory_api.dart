import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/assembler/inventory_assembler.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class InventoryFirestoreApi extends FirestoreApi implements InventoryApi {
  final ShopApi shopApi;

  InventoryFirestoreApi({required super.db, required this.shopApi});

  @override
  Future<Map<String, dynamic>> getInventory() async {
    try {
      final document = db.collection('inventory').doc(user.uid);
      final snapshot = await document.get();
      if (snapshot.exists) {
        final data = snapshot.data()!;
        final ids = [];
        Map items = data['items'];
        if (!items.isEmpty) {

          items.keys.forEach((key) {
            ids.add(key as String);
          });
          final shopItems = await shopApi.getItemsByIds(ids.cast<String>());
          data['items'] = Map.fromIterable(
            shopItems,
            key: (item) => item,
            value: (item) => true, // true need to replaced by item equipped or not
          );
        }
        return data;
      } else {
        final inventory = Inventory.empty();
        final json = InventoryAssembler.toJson(inventory);
        await document.set(json);
        return json;
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
