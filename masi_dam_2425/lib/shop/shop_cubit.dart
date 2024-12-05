import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/model/inventory.dart';


class ShopState {
  final List<Item>? shop;
  final bool isLoading;
  final String? errorMessage;

  ShopState({
    this.shop,
    this.isLoading = false,
    this.errorMessage,
  });

  ShopState copyWith({
    List<Item>? shop,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ShopState(
      shop: shop ?? this.shop,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ShopCubit extends Cubit<ShopState> {

   final ShopFirestoreApi api;

  ShopCubit(this.api) : super(ShopState());

  void loadShop() async {
    emit(state.copyWith(isLoading: true));
    try {
      final shop = await api.getItems();
      emit(state.copyWith(shop: shop, isLoading: false, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  } 

  // Function to buy an item
  void buyItem(Item item, Avatar player) {
    if (player.coins >= item.cost) {
      player.buy(item);
    } else {
      // Handle insufficient funds (can be done in UI with a message)
      print("Not enough coins to buy ${item.name}");
    }
  }
}
