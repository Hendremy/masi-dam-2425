import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/assembler/shop_item_assembler.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

class ShopFirestoreApi extends FirestoreApi implements ShopApi {
  ShopFirestoreApi({required super.db});

  @override
  Future<List<ShopItem>> getItems() async {
    List<ShopItem> items = [];
    try {
      final querySnapshot = await db.collection('shop').get();
      for (var doc in querySnapshot.docs) {
        final dataWithId = {
          ...doc.data(), // Spread the existing document data
          'id': doc.id,  // Add the id field
        };
        items.add(ShopItemAssembler.fromJson(dataWithId));
      }
    } catch (e) {
      print(e);
    } finally {
      return items;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getItemsByIds(List<String> ids) async {
    final List<Map<String, dynamic>>result = [];
    try {
      final querySnapshot =
          await db.collection('shop').where(FieldPath.documentId, whereIn: ids).get();
        for (var doc in querySnapshot.docs) {
          final dataWithId = {
            ...doc.data(), // Spread the existing document data
            'id': doc.id,  // Add the id field
          };
          result.add(dataWithId);
        }
    } catch (e) {
      print(e);
    } finally {
      return result;
    }
  }
}
