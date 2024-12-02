import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/api/avatar_api.dart';
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

  // Load the profile, including the avatar and user info
  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true)); // Start loading state
    try {
      final avatar = avatarCubit.state.avatar; // Access avatar from AvatarCubit
      final user = authRepo
          .currentUser; // Get the current user from AuthenticationRepository
      emit(state.copyWith(
          profile: Profile(avatar: avatar!, user: user),
          isLoading: false)); // Emit state with profile info
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString())); // Handle errors
    }
  }

  // Update profile details
  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  }) async {
    emit(state.copyWith(isLoading: true)); // Set loading state
    try {
      await avatarCubit.updateAvatar(displayName);
      await avatarCubit.api.updateProfileDetails(
        // Use AvatarCubit's API to update profile
        displayName: displayName,
        email: email,
        additionalData: additionalData,
      );
      final avatar = await avatarCubit.api.getAvatar(); // Fetch updated avatar
      final user = authRepo.currentUser; // Get current user
      emit(state.copyWith(
          profile: Profile(avatar: avatar!, user: user),
          isLoading: false)); // Emit updated profile state
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString())); // Handle errors
    }
  }
}
