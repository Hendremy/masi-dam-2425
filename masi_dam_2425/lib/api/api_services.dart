import 'package:masi_dam_2425/api/inventory_api.dart';
import 'package:masi_dam_2425/api/plants_api.dart';
import 'package:masi_dam_2425/api/profile_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/model/profile.dart';

class UserApiServices {
  final String userId;
  late InventoryApi inventoryApi;
  late PlantsApi plantsApi;
  late ProfileApi profileApi;

  UserApiServices({required this.userId, firestoreDb}){
    inventoryApi = InventoryFirestoreApi(db: firestoreDb, userId: userId);
    plantsApi = PlantsFirestoreApi(db: firestoreDb, userId: userId);
    profileApi = ProfileFirestoreApi(db: firestoreDb, userId: userId);
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