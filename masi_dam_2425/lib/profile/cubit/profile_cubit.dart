import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/model/profile.dart';
import 'package:masi_dam_2425/profile/cubit/avatar_cubit.dart';

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
  final AvatarCubit avatarCubit; // AvatarCubit for managing the avatar state
  final AuthenticationRepository
      authRepo; // AuthenticationRepository for the current user

  ProfileCubit(this.avatarCubit, this.authRepo) : super(ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true)); 
    try {
      final avatar = avatarCubit.state.avatar; 
      final user = authRepo
          .currentUser; 
      emit(state.copyWith(
          profile: Profile(avatar: avatar!, user: user),
          isLoading: false)); 
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> deleteAccount(String password) async {
    // Delete the user account
    await avatarCubit.api.deleteAvatar(password);
  }

  // Update profile details
  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await avatarCubit.updateAvatar(displayName);
      await avatarCubit.api.updateProfileDetails(
        displayName: displayName,
        email: email,
        additionalData: additionalData,
      );
      final avatar = await avatarCubit.api.getAvatar();
      final user = authRepo.currentUser;
      emit(state.copyWith(
          profile: Profile(avatar: avatar!, user: user), isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
