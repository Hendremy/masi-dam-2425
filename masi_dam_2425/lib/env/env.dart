import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
final class Env {

  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static String firebaseandroidapikey = _Env.firebaseandroidapikey;

  @EnviedField(varName: 'PLANT_NET_API_KEY', obfuscate: true)
  static String plantnetapikey = _Env.plantnetapikey;

}