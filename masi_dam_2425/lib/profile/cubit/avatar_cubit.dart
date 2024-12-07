// AvatarCubit to manage the avatar state
import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';

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

  AvatarCubit(this.api) : super(AvatarState());

  // Load the avatar from Firestore
  Future<void> loadAvatar() async {
    emit(state.copyWith(isLoading: true));
    try {
      final avatar = await api.getAvatar();
      emit(state.copyWith(avatar: avatar, isLoading: false, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  updateAvatar(String? displayName) {
    final avatar = state.avatar;
    if (avatar != null) {
      final updatedAvatar = avatar.copyWith(displayName: displayName);
      emit(state.copyWith(avatar: updatedAvatar));
    }
  }

}
