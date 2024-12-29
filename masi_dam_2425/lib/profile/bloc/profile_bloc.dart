import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/model/avatar.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final AvatarApi _repository;
  StreamSubscription<Avatar>? _profileSubscription;

  ProfileBloc({required AvatarApi repository})
      : _repository = repository,
        super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<_ProfileUpdated>(_onProfileUpdated);
    on<_ProfileError>(_onProfileError);

    _profileSubscription = _repository.avatarStream.listen(
          (profile) => add(_ProfileUpdated(profile)),
      onError: (error) => add(_ProfileError(error.toString())),
    );
  }

  Future<void> _onLoadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    await _repository.loadProfile();
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileUpdating());
    await _repository.updateProfile(event.profile);
  }

  void _onProfileUpdated(
      _ProfileUpdated event,
      Emitter<ProfileState> emit,
      ) {
    emit(ProfileLoaded(event.profile));
  }

  void _onProfileError(
      _ProfileError event,
      Emitter<ProfileState> emit,
      ) {
    emit(ProfileError(event.message));
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    _repository.dispose();
    return super.close();
  }

  Future<bool> deleteAccount(String password) async {
    try {
      return _repository.deleteProfile(password);
    } catch (e) {
      return false;
    }
  }
}
