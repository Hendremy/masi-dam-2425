import 'dart:async';

import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AvatarFirestoreApi extends FirestoreApi implements AvatarApi {
  late final FirebaseAuth auth;
  late final InventoryApi inventoryApi;

  final _profileController = StreamController<Avatar>.broadcast();
  Stream<Avatar> get avatarStream => _profileController.stream;

  AvatarFirestoreApi({
    required this.auth,
    required super.storage,
    required super.db,
    required this.inventoryApi,
  });

  Future<void> loadProfile() async {
    try {
      User? user = getUser();

      final document = db.collection('profiles').doc(user.uid);
      final snapshot = await document.get();

      if (snapshot.exists) {
        // Merge Firestore data with connection details from FirebaseAuth
        var json = {
          ...snapshot.data()!,
          'connectionData': {
            'email': user.email,
            'lastLogin': user.metadata.lastSignInTime,
            'firstLogin': user.metadata.creationTime,
            'isVerified': user.emailVerified,
          }
        };
        _profileController.add(Avatar.fromJson(json));
      } else {
        var accountData = {
          'email': user.email,
          'lastLogin': user.metadata.lastSignInTime,
          'firstLogin': user.metadata.creationTime,
          'isVerified': user.emailVerified,
        };
        var newProfile = Avatar.starter(user.displayName, accountData);
        await document.set(newProfile.toJson());
        _profileController.add(newProfile);
      }
    } catch (e) {
      _profileController.addError(e);
    }
  }

  Future<void> updateProfile(Avatar profile) async {
    try {
      User? user = getUser();

      await updateFirebaseUser(user, profile.name, profile.connectionData.email);
      final updates = <String, dynamic>{'name': profile.name};
      await updateFirestoreProfile(updates);

      _profileController.add(profile);
    } catch (e) {
      _profileController.addError(e);
    }
  }

  @override
  void dispose() {
    _profileController.close();
  }

  Future<void> updateFirestoreProfile(Map<String, dynamic> updates) async {
    User? user = getUser();

    await db.collection('profiles').doc(user.uid).update(updates);
  }

  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  }) async {
    User? user = getUser();

    await updateFirebaseUser(user, displayName, email);

    final updates = <String, dynamic>{
      if (displayName != null) 'name': displayName,
      if (additionalData != null) ...additionalData,
    };

    await updateFirestoreProfile(updates);
  }

  User getUser() {
    final user = auth.currentUser;
    if (user == null) throw Exception('No authenticated user');
    return user;
  }

  Future<void> updateFirebaseUser(User user, String? displayName, String? email) async {
    try {
      if (displayName != null && displayName != user.displayName) {
        await user.updateProfile(displayName: displayName);
      }

      if (email != null && email != user.email && user.emailVerified) {
        await user.verifyBeforeUpdateEmail(email);
      }

      await user.reload();
    } catch (e) {
      throw Exception('Failed to update user information: $e');
    }
  }

  @override
  Future<bool> deleteProfile(String password) async {
    final uid = getUser().uid;
    try {
      User? user = getUser();
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      // Reauthenticate and delete the user
      await user.reauthenticateWithCredential(credential);
      await db.collection('profiles').doc(uid).delete();
      await user.delete();
      return true;
    } on FirebaseAuthException catch (e) {
      throw Exception('Failed to delete user: $e');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
