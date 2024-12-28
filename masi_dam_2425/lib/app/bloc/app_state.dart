part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated, calendar, plants }

final class AppState extends Equatable {
  const AppState({User user = User.empty})
      : this._(
          status: user == User.empty
              ? AppStatus.unauthenticated
              : AppStatus.authenticated,
          user: user,
        );

  const AppState._({required this.status, this.user = User.empty});

  final AppStatus status;
  final User user;

  AppState copyWith({AppStatus? status, User? user}) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status, user];
}
