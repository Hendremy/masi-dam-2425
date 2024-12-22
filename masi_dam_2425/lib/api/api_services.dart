import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/api/inventory_api.dart';
import 'package:masi_dam_2425/api/plants_api.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

class UserApiServices {
  late InventoryApi inventoryApi;
  late PlantsApi plantsApi;
  late AvatarApi avatarApi;
  late ShopApi shopApi;

  UserApiServices({firestoreDb, auth}) {
    shopApi = ShopFirestoreApi(db: firestoreDb);
    inventoryApi = InventoryFirestoreApi(db: firestoreDb, shopApi: shopApi);
    plantsApi = PlantsFirestoreApi(db: firestoreDb);
    avatarApi = AvatarFirestoreApi(
        db: firestoreDb, auth: auth, inventoryApi: inventoryApi);
  }
}

abstract class InventoryApi {
  Future<void> loadInventory();
  Future<void> setEmptyInventory(document);
  Stream<Inventory> get inventoryStream;

  updateInventory(Inventory updatedProducts);
}

abstract class PlantsApi {
  Future<List<Plant>> getPlants();
}

abstract class ShopApi {
  Stream<List<ShopItem>> get productsStream;
  Future<void> loadItems();
  Future<List<Map<String, dynamic>>> getItemsByIds(List<String> ids);
  void dispose();
}

abstract class AvatarApi {
  Stream<Avatar> get avatarStream;
  Future<void> loadProfile();
  Future<void> updateProfile(Avatar profile);
  void dispose();
}
