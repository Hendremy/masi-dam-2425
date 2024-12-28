part of 'inventory_cubit.dart';

@immutable
sealed class InventoryState {
  const InventoryState();

  List<Object> get props => [];

  get coins => 0;

  get equippedItems => {};
}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final Inventory inventory;

  const InventoryLoaded(this.inventory);

  get coins => inventory.coins;
  get equippedItems => inventory.items.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key.image)
      .toList();

  @override
  List<Object> get props => [inventory];
}

class InventoryUpdated extends InventoryState {
  final String message;

  const InventoryUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class InventoryMessage extends InventoryState {
  final String message;

  const InventoryMessage(this.message);

  @override
  List<Object> get props => [message];
}

class InventoryError extends InventoryState {
  final String message;

  const InventoryError(this.message);

  @override
  List<Object> get props => [message];
}