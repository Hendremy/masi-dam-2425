import 'package:authentication_repository/authentication_repository.dart';
import 'package:masi_dam_2425/model/avatar.dart';

class Profile {
  final Avatar avatar;
  final User user;

  Profile({
    required this.avatar,
    required this.user,
  });

  Profile copyWith({
    Avatar? avatar,
    User? user,
  }) {
    return Profile(
      avatar: avatar ?? this.avatar,
      user: user ?? this.user,
    );
  }
}
