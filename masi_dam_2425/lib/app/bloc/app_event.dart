part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppUserLoginRequested extends AppEvent {
  const AppUserLoginRequested();
}

final class AppUserSubscriptionRequested extends AppEvent {
  const AppUserSubscriptionRequested();
}

final class AppLogoutPressed extends AppEvent {
  const AppLogoutPressed();
}
