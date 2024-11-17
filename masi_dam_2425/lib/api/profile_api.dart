import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/profile.dart';

class ProfileFirestoreApi extends FirestoreApi{
  ProfileFirestoreApi({required super.db});

  Future<Profile> getProfile({userId}) async{
    var document = db.collection('profiles').doc(userId);
    return document.get().then((value) {
        final data = value.data() as Map<String, dynamic>;
        return Profile.fromMap(data);
    },);
  }
}