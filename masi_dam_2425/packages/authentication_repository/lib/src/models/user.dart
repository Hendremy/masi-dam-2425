import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.emailVerified,
    this.creationDate,
    this.lastSignInDate,
    this.password,
  });

  String? get formattedAccountCreationDate {
    if (creationDate == null) return null;
    return '${creationDate!.day.toString().padLeft(2, '0')}/${creationDate!.month.toString().padLeft(2, '0')}/${creationDate!.year}';
  }

  String? get formattedAccountLastLoginDate {
    if (lastSignInDate == null) return null;
    return '${lastSignInDate!.day.toString().padLeft(2, '0')}/${lastSignInDate!.month.toString().padLeft(2, '0')}/${lastSignInDate!.year}';
  }


  final DateTime? creationDate;
  final DateTime? lastSignInDate;

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  final bool? emailVerified;

  final String? password;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  @override
  List<Object?> get props => [email, password, id, name, photo, emailVerified, creationDate, lastSignInDate];
}
