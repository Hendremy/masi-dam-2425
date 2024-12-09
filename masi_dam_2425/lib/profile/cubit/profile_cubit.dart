import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:masi_dam_2425/model/profile.dart';

class ProfileState {
  final Profile? profile;
  final bool isLoading;
  final String? errorMessage;

  ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  get avatar => this.profile?.avatar;
  get user => this.profile?.user;

  ProfileState copyWith({
    Profile? profile,
    bool? isLoading,
    bool? canUpdateCriticalData,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  final AvatarFirestoreApi avatarApi;
  final AuthenticationRepository authRepo;

  late final StreamSubscription<Avatar> _avatarSubscription;

  ProfileCubit(this.avatarApi, this.authRepo) : super(ProfileState()) {
    _initialize();
  }

  void _initialize() {
    emit(state.copyWith(isLoading: true));
    _avatarSubscription = avatarApi.avatarStream().listen(
      (avatar) => emit(state.copyWith(profile: Profile(avatar: avatar, user: authRepo.currentUser), isLoading: false)),
      onError: (error) => emit(state.copyWith(errorMessage: error.toString(), isLoading: false)),
    );
  }


  @override
  Future<void> close() {
    _avatarSubscription.cancel();
    return super.close();
  }


  Future<void> deleteAccount(String password) async {
    // Delete the user account
    await avatarApi.deleteAvatar(password);
    // await authRepo.deleteAccount(password);
  }

  // Update profile details
  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await avatarApi.updateProfileDetails(
        displayName: displayName,
        email: email,
        additionalData: additionalData,
      );      
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
