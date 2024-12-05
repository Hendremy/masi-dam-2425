import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class ShopFirestoreApi extends FirestoreApi implements ShopApi {
  ShopFirestoreApi({required super.db});

  @override
  Future<List<Item>> getItems() async{
    List<Item> items = [];
    try{
      final querySnapshot = await db.collection('shop').get(
        
      );
      for (var doc in querySnapshot.docs) {
        items.add(Item.fromMap(doc.data()));
      }
    }catch(e){
      print(e);
    } finally {
      return items;
    } 
  }
}