import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/api/inventory_api.dart';
import 'package:masi_dam_2425/api/plants_api.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
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
    avatarApi = AvatarFirestoreApi(db: firestoreDb, auth: auth, inventoryApi: inventoryApi);
  }
}

abstract class InventoryApi {
  Future<Map<String, dynamic>?> getInventory();
}

abstract class PlantsApi {
  Future<List<Plant>> getPlants();
}

abstract class ShopApi {
  Future<List<ShopItem>?> getItems();
  Future<List<Map<String, dynamic>>> getItemsByIds(List<String> ids);
}

abstract class AvatarApi {
  Future<Avatar?> getAvatar();
  Future<void> updateFirestoreProfile(Map<String, dynamic> updates);
  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  });
}
