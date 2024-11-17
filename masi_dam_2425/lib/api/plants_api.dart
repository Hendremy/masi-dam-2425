import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/plant.dart';


class PlantsFirestoreApi extends FirestoreApi implements PlantsApi{
  PlantsFirestoreApi({required super.db, required super.userId});

  @override
  Future<List<Plant>> getPlants() async{
    //var document = db.collection('plants').doc(userId);
    //return document.get().then((value) {
    //    List<Plant> plants = [];
    //    final data = value.data() as Map<String, dynamic>;
    //    dynamic plantMaps = data["plants"];
    //    for(var plantMap in plantMaps){
    //      plants.add(Plant.fromMap(plantMap));
    //    }
    //    return plants;
    //},).catchError((err) => List<Plant>.empty());
    return [];
  }
}