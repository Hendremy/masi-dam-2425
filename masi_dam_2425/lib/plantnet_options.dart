import 'package:masi_dam_2425/env/env.dart';

class PlantnetOptions {
  final String apiKey;

  PlantnetOptions({required this.apiKey});

  static PlantnetOptions get currentPlatform {
    return PlantnetOptions(apiKey: Env.plantnetapikey);
  }
}