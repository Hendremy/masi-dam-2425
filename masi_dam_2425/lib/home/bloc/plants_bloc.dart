import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/plant.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  final PlantsApi api;

  PlantsBloc({required this.api}) : super(PlantsState(plants: [], isLoading: false)) {
    on<PlantsLoaded>((event, emit) {
      emit(PlantsState(plants: event.plants, isLoading: false));
    });

    on<PlantsLoadFailed>((event, emit){
      emit(PlantsState(plants: [], isLoading: false));
    });

    on<PlantsLoading>((event, emit){
      emit(PlantsState(plants: [], isLoading: true));
    });

    _loadPlants();
  }

  Future<void> _loadPlants() async {
    emit(PlantsState(plants: [], isLoading: true));
    List<Plant> plants = await api.getPlants();
    emit(PlantsState(plants: plants, isLoading: false));
  }
}

// Events

abstract class PlantsEvent {
  const PlantsEvent([List props = const []]);
}

class PlantsLoaded extends PlantsEvent {
  final List<Plant> plants;

  PlantsLoaded({required this.plants});
}

class PlantsLoadFailed extends PlantsEvent {}

class PlantsLoading extends PlantsEvent{}

// States


class PlantsState {
  final List<Plant> plants;
  final bool isLoading;

  PlantsState({
    required this.plants,
    required this.isLoading
  });
}

