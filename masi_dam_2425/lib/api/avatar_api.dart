import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/assembler/avatar_assembler.dart';
import 'package:masi_dam_2425/model/assembler/inventory_assembler.dart';
import 'package:masi_dam_2425/model/avatar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:masi_dam_2425/model/inventory.dart';

class AvatarFirestoreApi extends FirestoreApi implements AvatarApi {
  final FirebaseAuth auth;
  final InventoryApi inventoryApi;

  AvatarFirestoreApi(
      {required this.auth, required super.db, required this.inventoryApi});

  Future<Avatar?> getAvatar() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    final doc = db.collection('profiles').doc(user.uid);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      final inventory = await inventoryApi.getInventory();
      final json = snapshot.data()!;
      json['inventory'] = inventory;
      return AvatarAssembler.fromJson(json);
    } else {
      final avatar = Avatar.starter(user.displayName, user.email);
      await doc.set(AvatarAssembler.toJson(avatar));
      return avatar;
    }
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
    if (user == null) throw Exception('No authenticated user');

    if (displayName != null && displayName != user.displayName) {
      await user.updateProfile(displayName: displayName);
    }

    if (email != null && email != user.email && user.emailVerified) {
      await user.verifyBeforeUpdateEmail(email);
    }

    await user.reload();

    final updates = <String, dynamic>{
      if (displayName != null) 'name': displayName,
      if (email != null) 'email': email,
      if (additionalData != null) ...additionalData,
    };

    await updateFirestoreProfile(updates);
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

  Future<void> updateInventory(Inventory inventory) async {
    await db.collection('inventory').doc(auth.currentUser?.uid).update(InventoryAssembler.toJson(inventory));
  }
}
