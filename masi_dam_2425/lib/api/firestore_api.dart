import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreApi{
  final FirebaseFirestore db;
  late User user;

  FirestoreApi({
    required this.db
  }) {
    user = FirebaseAuth.instance.currentUser!;
  }
}