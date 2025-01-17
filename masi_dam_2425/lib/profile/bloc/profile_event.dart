part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {
  const ProfileEvent();

  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final Avatar profile;

  const UpdateProfile(this.profile);

  @override
  List<Object> get props => [profile];
}

class _ProfileUpdated extends ProfileEvent {
  final Avatar profile;

  const _ProfileUpdated(this.profile);

  @override
  List<Object> get props => [profile];
}

class _ProfileError extends ProfileEvent {
  final String message;

  const _ProfileError(this.message);

  @override
  List<Object> get props => [message];
}