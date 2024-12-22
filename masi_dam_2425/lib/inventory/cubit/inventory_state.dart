part of 'inventory_cubit.dart';

@immutable
sealed class InventoryState {
  const InventoryState();

  List<Object> get props => [];

  get coins => 0;
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final Inventory inventory;

  const InventoryLoaded(this.inventory);

  get coins => inventory.coins;

  @override
  List<Object> get props => [inventory];
}

class InventoryError extends InventoryState {
  final String message;

  const InventoryError(this.message);

  @override
  List<Object> get props => [message];
}