import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class InventoryFirestoreApi extends FirestoreApi{
  InventoryFirestoreApi({required super.db});

  Future<Inventory> getInventory({userId}) async{
    var document = db.collection('inventory').doc(userId);
    return document.get().then((value) {
        final data = value.data() as Map<String, dynamic>;
        return Inventory.fromMap(data);
    },);
  }
}