import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masi_dam_2425/model/profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState(profile: null, isLoading: false)) {
    on<ProfileLoaded>((event, emit) {
      emit(ProfileState(profile: event.profile, isLoading: false));
    });

    on<ProfileLoadFailed>((event, emit){
      emit(ProfileState(profile: null, isLoading: false));
    });

    on<ProfileLoading>((event, emit){
      emit(ProfileState(profile: null, isLoading: true));
    });
  }
}

// Events

abstract class ProfileEvent {
  const ProfileEvent([List props = const []]);
}

class ProfileLoaded extends ProfileEvent {
  final Profile profile;

  ProfileLoaded({required this.profile});
}

class ProfileLoadFailed extends ProfileEvent {}

class ProfileLoading extends ProfileEvent{}

// States


class ProfileState {
  final Profile? profile;
  final bool isLoading;

  ProfileState({
    required this.profile,
    required this.isLoading
  });
}

