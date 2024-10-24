import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'FIREBASE_WEB_API_KEY', obfuscate: true)
  static String firebasewebapikey = _Env.firebasewebapikey;

  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static String firebaseandroidapikey = _Env.firebaseandroidapikey;

  @EnviedField(varName: 'FIREBASE_WIN_API_KEY', obfuscate: true)
  static String firebasewinapikey = _Env.firebasewinapikey;
}