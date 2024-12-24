import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';

abstract class PlantRegistrationState{

}

class PlantRegistrationInitial extends PlantRegistrationState{

}

class PlantRegistriationSaving extends PlantRegistrationState{

}

class PlantRegistrationSaved extends PlantRegistrationState{

}


class PlantRegistrationCubit extends Cubit<PlantRegistrationState>{
  final PlantsApi api;
  PlantRegistrationCubit({required PlantsApi this.api}) : super(PlantRegistrationInitial());

  Future<void> savePlant(String name, File img) async{
    // save plant to firestore
    emit(PlantRegistriationSaving());
    await api.addPlant(name, img);
    emit(PlantRegistrationSaved());
  }
}