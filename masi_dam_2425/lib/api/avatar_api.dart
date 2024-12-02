import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/avatar.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AvatarFirestoreApi extends FirestoreApi implements AvatarApi{
  final FirebaseAuth auth;

  AvatarFirestoreApi({required this.auth, required super.db});

  // Fetch Avatar from Firestore
  Future<Avatar?> getAvatar() async {
    final user = auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    final doc = db.collection('profiles').doc(user.uid);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      return Avatar.fromMap(snapshot.data()!);
    } else {
      // Create a starter profile
      final avatar = Avatar.starter(user.displayName, user.email);
      await doc.set(avatar.toMap());
      return avatar;
    }
  }

  // Update Firestore profile
  Future<void> updateFirestoreProfile(Map<String, dynamic> updates) async {
    await db.collection('profiles').doc(auth.currentUser?.uid).update(updates);
  }

  // Update FirebaseAuth and Firestore
  Future<void> updateProfileDetails({
    String? displayName,
    String? email,
    Map<String, dynamic>? additionalData,
  }) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('No authenticated user');

    // Update FirebaseAuth profile
    if (displayName != null && displayName != user.displayName) {
      await user.updateProfile(displayName: displayName);
    }
    
    if (email != null && email != user.email && user.emailVerified) {
      await user.verifyBeforeUpdateEmail(email);
    }

    await user.reload();

    // Update Firestore profile
    final updates = <String, dynamic>{
      if (displayName != null) 'name': displayName,
      if (email != null) 'email': email,
      if (additionalData != null) ...additionalData,
    };

    await updateFirestoreProfile(updates);
  }
}

