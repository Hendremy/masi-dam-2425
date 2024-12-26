import 'dart:io';

import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/api/inventory_api.dart';
import 'package:masi_dam_2425/api/plantnet_api.dart';
import 'package:masi_dam_2425/api/plants_api.dart';
import 'package:masi_dam_2425/model/inventory.dart';
import 'package:masi_dam_2425/model/plant.dart';
import 'package:masi_dam_2425/model/avatar.dart';

class UserApiServices {
  late InventoryApi inventoryApi;
  late PlantsApi plantsApi;
  late AvatarApi avatarApi;
  late PlantIdApi plantIdApi;

  UserApiServices({firestoreDb, firebaseStorage, auth, plantnetOptions}) {
    inventoryApi = InventoryFirestoreApi(db: firestoreDb, storage: firebaseStorage);
    plantsApi = PlantsFirestoreApi(db: firestoreDb, storage: firebaseStorage);
    avatarApi = AvatarFirestoreApi(db: firestoreDb, storage: firebaseStorage,auth: auth);
    plantIdApi = PlantnetApi(apiKey: plantnetOptions.apiKey);
  }
}

abstract class InventoryApi {
  Future<Inventory?> getInventory();
}

abstract class PlantsApi {
  Future<List<Plant>> getPlants();
  Future<void> addPlant(String name, File img);
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

abstract class PlantIdApi {
  Future<String> identifyPlant(File img);
}