import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirestoreApi{
  final FirebaseFirestore db;
  final FirebaseStorage storage;
  late User user;


  FirestoreApi({
    required this.db,
    required this.storage
  }) {
    user = FirebaseAuth.instance.currentUser!;
  }
}