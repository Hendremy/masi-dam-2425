import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'FIREBASE_WEB_API_KEY', obfuscate: true)
  static String firebasewebapikey = _Env.firebase_web_api_key;

  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static String firebaseandroidapikey = _Env.firebase_android_api_key;

  @EnviedField(varName: 'FIREBASE_WIN_API_KEY', obfuscate: true)
  static String firebasewinapikey = _Env.firebase_win_api_key;
}