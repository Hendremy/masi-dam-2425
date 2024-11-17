import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreApi{
  final FirebaseFirestore db;
  final String userId;

  const FirestoreApi({
    required this.db,
    required this.userId
  });
}