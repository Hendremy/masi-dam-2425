import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/plant.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  
  final String _PH_ID = '07n8hjEJ9P1xyv9sS7DA';

  PlantsBloc() : super(PlantsState(plants: [], isLoading: false)) {
    on<PlantsLoaded>((event, emit) {
      emit(PlantsState(plants: event.plants, isLoading: false));
    });

    on<PlantsLoadFailed>((event, emit){
      emit(PlantsState(plants: [], isLoading: false));
    });

    on<PlantsLoading>((event, emit){
      emit(PlantsState(plants: [], isLoading: true));
    });
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

