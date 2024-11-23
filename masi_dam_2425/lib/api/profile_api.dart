import 'package:masi_dam_2425/api/api_services.dart';
import 'package:masi_dam_2425/api/firestore_api.dart';
import 'package:masi_dam_2425/model/profile.dart';

class ProfileFirestoreApi extends FirestoreApi implements ProfileApi{
  ProfileFirestoreApi({required super.db});

  @override
  Future<Profile?> getProfile() async{
    try{
    final document = db.collection('profiles').doc(userId);
    final snapshot = await document.get();
    Profile profile;

    if (!snapshot.exists){
      profile = Profile.empty();
      document.set(profile.toMap());
    }else{
      final data = snapshot.data() as Map<String, dynamic>;
      profile =  Profile.fromMap(data);
    }

    return profile;
    
    }catch(e){
      print(e);
      return null;
    }
  }
}