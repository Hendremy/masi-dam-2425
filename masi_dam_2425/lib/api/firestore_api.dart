import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreApi{
  final FirebaseFirestore db;

  const FirestoreApi({
    required this.db
  });
}