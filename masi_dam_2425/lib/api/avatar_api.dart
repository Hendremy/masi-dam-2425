import 'dart:async';

import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AvatarFirestoreApi extends FirestoreApi implements AvatarApi {
  late FirebaseAuth auth;
  late InventoryApi inventoryApi;

  final _profileController = StreamController<Avatar>.broadcast();
  Stream<Avatar> get avatarStream => _profileController.stream;

  AvatarFirestoreApi(
      {required this.auth, required super.storage, required super.db, required this.inventoryApi});

  Future<void> loadProfile() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        throw Exception('No authenticated user');
      }

      final document = db.collection('profiles').doc(user.uid);
      final snapshot = await document.get();

      if (snapshot.exists) {
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
        _profileController.add(Avatar.starter(user.displayName, accountData));
      }
    } catch (e) {
      _profileController.addError(e);
    }
  }

  Future<void> updateProfile(Avatar profile) async {
    try {
      final user = auth.currentUser;
      await updateFirebaseUser(
          user, profile.name, profile.connectionData.email);
      final updates = <String, dynamic>{
        'name': profile.name,
      };
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
    await db.collection('profiles').doc(auth.currentUser?.uid).update(updates);
  }

  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  }) async {
    final user = auth.currentUser;
    await updateFirebaseUser(user, displayName, email);
    final updates = <String, dynamic>{
      if (displayName != null) 'name': displayName,
      if (additionalData != null) ...additionalData,
    };

    await updateFirestoreProfile(updates);
  }

  Future<void> updateFirebaseUser(
      User? user, String? displayName, String? email) async {
    if (user == null) throw Exception('No authenticated user');

    if (displayName != null && displayName != user.displayName) {
      await user.updateProfile(displayName: displayName);
    }

    if (email != null && email != user.email && user.emailVerified) {
      await user.verifyBeforeUpdateEmail(email);
    }

    await user.reload();
  }

  deleteAvatar(String password) async {
    // Delete the user's profile
    try {
      final user = auth.currentUser;

      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
        await user.delete();
        db.collection('profiles').doc(user.uid).delete();
      } else {
        throw Exception('No authenticated user');
      }
    } on FirebaseAuthException {
    } catch (e) {}
  }
}
