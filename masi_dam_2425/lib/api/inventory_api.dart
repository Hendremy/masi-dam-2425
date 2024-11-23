import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class InventoryFirestoreApi extends FirestoreApi implements InventoryApi{
  InventoryFirestoreApi({required super.db});

  @override
  Future<Inventory?> getInventory() async{
    try{
      final document = db.collection('inventory').doc(userId);
      final snapshot = await document.get();
      Inventory inventory;

      if (!snapshot.exists){
        inventory = Inventory.empty();
        await document.set(inventory.toMap());
      }else{
        final data = snapshot.data() as Map<String, dynamic>;
        inventory = Inventory.fromMap(data);
      }

      return inventory;

    }catch(e){
      print(e);
      return null;
    }
  }
}