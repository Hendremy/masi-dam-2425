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
    inventoryApi = InventoryFirestoreApi(db: firestoreDb);
    plantsApi = PlantsFirestoreApi(db: firestoreDb);
    avatarApi = AvatarFirestoreApi(db: firestoreDb, auth: auth);
    shopApi = ShopFirestoreApi(db: firestoreDb);
  }
}

abstract class InventoryApi {
  Future<Inventory?> getInventory();
}

abstract class PlantsApi {
  Future<List<Plant>> getPlants();
}

abstract class ShopApi {
  Future<List<ShopItem>?> getItems();
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
