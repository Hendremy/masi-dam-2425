import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/profile.dart';

class ProfileFirestoreApi extends FirestoreApi implements ProfileApi{
  ProfileFirestoreApi({required super.db, required super.userId});

  @override
  Future<Profile?> getProfile() async{
    //var document = db.collection('profiles').doc(userId);
    //return document.get().then((value) {
    //    final data = value.data() as Map<String, dynamic>;
    //    return Profile.fromMap(data);
    //},).catchError((err){
    //  print(err);
    //  return null;
    //});
    return Profile(name: 'Test', title: 'title', level: 4, xp: 50);
  }
}