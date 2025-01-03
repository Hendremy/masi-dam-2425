import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/plant.dart';

class PlantState{
  
}

class PlantInitial extends PlantState{
  PlantInitial();
}

class PlantGainedXP extends PlantState{
  final double xp_gain;
  PlantGainedXP(this.xp_gain);
}

class PlantCubit extends Cubit<PlantState>{
  final Plant plant;
  final PlantsApi api;

  PlantCubit(
    this.plant,
    this.api
    ) : super(PlantInitial());

  void waterPlant(){
    double xp_gain = plant.giveWater();
    api.updatePlant(plant);
    emit(PlantGainedXP(xp_gain));
  }
}