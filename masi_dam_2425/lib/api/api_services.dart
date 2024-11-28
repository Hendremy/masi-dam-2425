import 'package:masi_dam_2425/api/inventory_api.dart';
import 'package:masi_dam_2425/api/plants_api.dart';
import 'package:masi_dam_2425/api/profile_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/model/profile.dart';

class UserApiServices {
  late InventoryApi inventoryApi;
  late PlantsApi plantsApi;
  late ProfileApi profileApi;

  UserApiServices({firestoreDb}){
    inventoryApi = InventoryFirestoreApi(db: firestoreDb);
    plantsApi = PlantsFirestoreApi(db: firestoreDb);
    profileApi = ProfileFirestoreApi(db: firestoreDb);
  }
  
}

abstract class InventoryApi {
  Future<Inventory?> getInventory();
}

abstract class PlantsApi{
  Future<List<Plant>> getPlants();
}

abstract class ProfileApi{
  Future<Profile?> getProfile() ;
}