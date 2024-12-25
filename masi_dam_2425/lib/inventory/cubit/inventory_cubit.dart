import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

import '../../model/inventory.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {

  final InventoryApi repository;

  InventoryCubit(this.repository) : super(InventoryInitial()) {
    repository.inventoryStream.listen(
          (products) => emit(InventoryLoaded(products)),
      onError: (error) => emit(InventoryError(error.toString())),
    );
  }

  Future<void> loadInventory() async {
    try {
      emit(InventoryLoading());
      await repository.loadInventory();
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  void add(ShopItem product) async {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedProducts = currentState.inventory..add(product);
      await repository.updateInventory(updatedProducts);
      emit(InventoryUpdated("Inventory updated"));
      emit(InventoryLoaded(updatedProducts));
    }
  }

  void toggleItem(ShopItem item) async {
    if (state is InventoryLoaded) {
      final currentState = state as InventoryLoaded;
      final updatedProducts = currentState.inventory..toggleItem(item);
      await repository.updateInventory(updatedProducts);
      emit(InventoryUpdated("Inventory updated"));
      emit(InventoryLoaded(updatedProducts));
    }
  }

}
