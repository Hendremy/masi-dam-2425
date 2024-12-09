import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/api/shop_api.dart';
import 'package:masi_dam_2425/model/shop_item.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';


class ShopState {
  final List<ShopItem>? shop;
  final bool isLoading;
  final String? errorMessage;

  ShopState({
    this.shop,
    this.isLoading = false,
    this.errorMessage,
  });

  ShopState copyWith({
    List<ShopItem>? shop,
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

  final AvatarCubit avatarCubit; // AvatarCubit for managing the avatar state
  final ShopFirestoreApi api;

  ShopCubit(this.api, this.avatarCubit) : super(ShopState());

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
  void buyItem(ShopItem item) async {
    emit(state.copyWith(isLoading: true));
    if (avatarCubit.state.avatar?.coins >= item.cost) {
      try {
        // Local update
        avatarCubit.state.avatar?.inventory.add(item);
        avatarCubit.state.avatar?.buy(item);
        avatarCubit.emit(avatarCubit.state.copyWith(avatar: avatarCubit.state.avatar));
        // Remote update
        avatarCubit.api.updateInventory(avatarCubit.state.avatar!.inventory);
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      }
      
    } else {
      // Handle insufficient funds (can be done in UI with a message)
      emit(state.copyWith(isLoading: false, errorMessage: "Insufficient funds"));
    }
  }
}
