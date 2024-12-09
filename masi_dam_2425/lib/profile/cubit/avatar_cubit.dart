// AvatarCubit to manage the avatar state
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/model/shop_item.dart';

class AvatarState {
  final Avatar? avatar;
  final bool isLoading;
  final String? errorMessage;

  AvatarState({
    this.avatar,
    this.isLoading = false,
    this.errorMessage,
  });

  AvatarState copyWith({
    Avatar? avatar,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AvatarState(
      avatar: avatar ?? this.avatar,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class AvatarCubit extends Cubit<AvatarState> {
  final AvatarFirestoreApi api;
  late final StreamSubscription<Avatar> _subscription;

  AvatarCubit(this.api) : super(AvatarState()) {
    _initialize();
  }

  void _initialize() {
    emit(state.copyWith(isLoading: true));
    _subscription = api.avatarStream().listen(
      (avatar) => emit(state.copyWith(avatar: avatar, isLoading: false)),
      onError: (error) => emit(state.copyWith(errorMessage: error.toString(), isLoading: false)),
    );
  }

  Future<void> addItem(ShopItem item) async {
    emit(state.copyWith(isLoading: true));
    try {
      final avatar = state.avatar?.addItemToInventory(item);
      if (avatar == null) throw Exception('No avatar found to update');
      emit(state.copyWith(avatar: avatar));
      await api.updateInventory(avatar.inventory);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateAvatar(String? displayName) {
    final avatar = state.avatar;
    if (avatar != null) {
      final updatedAvatar = avatar.copyWith(name: displayName);
      emit(state.copyWith(avatar: updatedAvatar));
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}