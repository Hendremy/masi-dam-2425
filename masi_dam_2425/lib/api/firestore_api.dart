import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreApi{
  final FirebaseFirestore db;
  late String userId;

  FirestoreApi({
    required this.db
  }){
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      userId = user.uid;
    }else{
      userId = '';
    }}
}