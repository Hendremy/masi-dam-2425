import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/profile.dart';

class InventoryFirestoreApi extends FirestoreApi implements InventoryApi{
  InventoryFirestoreApi({required super.db, required super.userId});

  @override
  Future<Inventory?> getInventory() async{
    //var document = db.collection('inventory').doc(userId);
    //return document.get().then((value) {
    //    final data = value.data() as Map<String, dynamic>;
    //    return Inventory.fromMap(data);
    //},).catchError((err){
    //  print(err);
    //  return null;
    //});
    return Inventory(coins: 40, items: []);
  }
}