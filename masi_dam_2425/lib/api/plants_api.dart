import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/plant.dart';


class PlantsFirestoreApi extends FirestoreApi implements PlantsApi{
  PlantsFirestoreApi({required super.db, required super.storage});

  @override
  Future<List<Plant>> getPlants() async{
    try{
      final document = db.collection('plants').doc(user.uid);
      final snapshot = await document.get();
      List<Plant> plants;

      if (!snapshot.exists){
        plants = List<Plant>.empty();
        await document.set({'plants': plants});
      }else{
          final data = snapshot.data() as Map<String, dynamic>;
          plants = [];
          dynamic plantMaps = data["plants"];

          for(var plantMap in plantMaps){
            plants.add(Plant.fromMap(plantMap));
          }
      }
        return plants;
      }catch(e){
      print(e);
      return List<Plant>.empty();
    }}

    @override
    Future<void> addPlant(String name, File img) async{
        final document = db.collection('plants').doc(user.uid);
        await document.get();

        List<Plant> plants = await getPlants();
        Plant newPlant = Plant.empty();
        newPlant.name = name;
        plants.add(newPlant);

        print(img.path);

        String fileExtension = p.extension(img.path);
        final storageRef = storage.ref();
        final newPlantRef = storageRef.child("plants/${newPlant.uuid}${fileExtension}");
        UploadTask upload = newPlantRef.putFile(img);
        await upload.whenComplete((){});
        await document.set({'plants': plants.map((e) => e.toMap()).toList()});  
        //});
    }
}