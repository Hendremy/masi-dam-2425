import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';

class PlantIdState {
  const PlantIdState();
}

class PlantIdCubit extends Cubit<PlantIdState>{
  final PlantIdApi api;

  PlantIdCubit({required this.api}): super(PlantIdInitial());

  Future<void> identifyPlant(File img) async{
    try{
      emit(PlantIdSearching());
      String species = await api.identifyPlant(img);
      if(species.isNotEmpty){
        emit(PlantIdFound(species: species));
      }else{
        emit(PlantIdNotFound());
      }
    }catch(e){
      emit(PlantIdError(message: e.toString()));
    }
  }
}

class PlantIdSearching extends PlantIdState{

}

class PlantIdInitial extends PlantIdState{

}

class PlantIdFound extends PlantIdState{
  final String species;

  PlantIdFound({required this.species});
}

class PlantIdNotFound extends PlantIdState{

}

class PlantIdError extends PlantIdState{
  final String message;

  PlantIdError({required this.message});
}