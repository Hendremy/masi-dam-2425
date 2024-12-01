import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
final class Env {

  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static String firebaseandroidapikey = _Env.firebaseandroidapikey;

}