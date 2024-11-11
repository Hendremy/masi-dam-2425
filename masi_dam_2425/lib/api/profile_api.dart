import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masi_dam_2425/model/profile.dart';

abstract class ProfileApi {
  
}

class FirestoreProfileApi{
  final FirebaseFirestore db;

  const FirestoreProfileApi({
    required this.db
  });

  Future<Profile> getProfile({userId}) async{
    var document = db.collection('profiles').doc('07n8hjEJ9P1xyv9sS7DA');
    return document.get().then((value) {
        final data = value.data() as Map<String, dynamic>;
        return Profile.fromMap(data);
    },);
  }
}