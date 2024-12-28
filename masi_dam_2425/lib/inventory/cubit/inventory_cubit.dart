import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

import '../../exceptions/already_in_possession_exception.dart';
import '../../exceptions/insufficient_funds_exception .dart';
import '../../model/inventory.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final InventoryApi repository;

  InventoryCubit(this.repository) : super(InventoryInitial()) {
    // Listen to the inventory stream and update state
    repository.inventoryStream.listen(
          (inventory) => emit(InventoryLoaded(inventory)),
      onError: (error) => emit(InventoryError(error.toString())),
    );
  }

  Future<void> loadInventory() async {
    emit(InventoryLoading());
    try {
      await repository.loadInventory();
    } catch (e) {
      emit(InventoryError('Failed to load inventory: $e'));
    }
  }

  Future<void> add(ShopItem product) async {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;

      try {
        final updatedProducts = currentState.inventory..add(product);
        await repository.updateInventory(updatedProducts);
        emit(InventoryUpdated("Added ${product.name} to inventory."));
        emit(InventoryLoaded(updatedProducts));
      } on InsufficientFundsException catch (e) {
        emit(InventoryMessage('$e'));
        emit(InventoryLoaded(currentState.inventory));
      } on AlreadyInPossessionException catch (e) {
        emit(InventoryMessage('$e'));
        emit(InventoryLoaded(currentState.inventory));
      } catch (e) {
        emit(InventoryError('$e'));
      }
    }
  }

  Future<void> toggleItem(ShopItem item) async {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;

      try {
        final updatedProducts = currentState.inventory..toggleItem(item);
        await repository.updateInventory(updatedProducts);
        emit(InventoryUpdated("${item.name} state updated."));
        emit(InventoryLoaded(updatedProducts));
      } catch (e) {
        emit(InventoryError('Failed to toggle item: $e'));
      }
    }
  }
}

