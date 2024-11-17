import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  
  final String _PH_ID = '07n8hjEJ9P1xyv9sS7DA';

  InventoryBloc() : super(InventoryState(inventory: null, isLoading: false)) {
    on<InventoryLoaded>((event, emit) {
      emit(InventoryState(inventory: event.inventory, isLoading: false));
    });

    on<InventoryLoadFailed>((event, emit){
      emit(InventoryState(inventory: null, isLoading: false));
    });

    on<InventoryLoading>((event, emit){
      emit(InventoryState(inventory: null, isLoading: true));
    });
  }
}

// Events

abstract class InventoryEvent {
  const InventoryEvent([List props = const []]);
}

class InventoryLoaded extends InventoryEvent {
  final Inventory inventory;

  InventoryLoaded({required this.inventory});
}

class InventoryLoadFailed extends InventoryEvent {}

class InventoryLoading extends InventoryEvent{}

// States


class InventoryState {
  final Inventory? inventory;
  final bool isLoading;

  InventoryState({
    required this.inventory,
    required this.isLoading
  });
}

