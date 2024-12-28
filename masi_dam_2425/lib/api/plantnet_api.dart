import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:masi_dam_2425/api/api_services.dart';

class PlantnetIdentifyResult {
  final double score;
  final String scientificNameWithoutAuthor;
  final String scientificNameAuthorship;
  final String genus;
  final String family;
  final List<String> commonNames;
  final String scientificName;

  PlantnetIdentifyResult({
    required this.score,
    required this.scientificNameWithoutAuthor,
    required this.scientificNameAuthorship,
    required this.genus,
    required this.family,
    required this.commonNames,
    required this.scientificName
  });
}

class PlantnetIdentifyResponse {
  final String bestMatch;
  final List<PlantnetIdentifyResult> results;

  PlantnetIdentifyResponse({required this.bestMatch, required this.results});
}

class PlantnetApi extends PlantIdApi {
  final String apiKey;
  final String url = "https://my-api.plantnet.org";

  PlantnetApi({required this.apiKey});
  
  @override
  Future<String> identifyPlant(File img) async {
    final String route = '/v2/identify/all?api-key=$apiKey';
    final Uri path = Uri.parse('$url$route');

    var request = new http.MultipartRequest("POST", path);
    var file = await http.MultipartFile.fromPath(
        'images',
        img.path,
        contentType: MediaType('image', 'jpeg'));
    request.files.add(file);
    var response = await request.send();
    switch(response.statusCode){
      case 200:
        var responseString = await response.stream.bytesToString();
        var rjson = jsonDecode(responseString);
        return rjson['bestMatch'];
      case 400:
        throw Exception('Bad request');
      case 401:
        throw Exception('Unauthorized');
      case 403:
        throw Exception('Forbidden');
      case 404:// If not found, return nothing
        return '';
      case 500:
        throw Exception('Internal server error');
      default:
        throw Exception('Unknown error');
    }
  }
}


// Example response for identification
// {
//   "query": {
//     "project": "all",
//     "images": [
//       "7bb31b48bcb17980d3b003ee01995992"
//     ],
//     "organs": [
//       "auto"
//     ],
//     "includeRelatedImages": false,
//     "noReject": false
//   },
//   "language": "en",
//   "preferedReferential": "k-world-flora",
//   "bestMatch": "Furcraea foetida (L.) Haw.",
//   "results": [
//     {
//       "score": 0.59878,
//       "species": {
//         "scientificNameWithoutAuthor": "Furcraea foetida",
//         "scientificNameAuthorship": "(L.) Haw.",
//         "genus": {
//           "scientificNameWithoutAuthor": "Furcraea",
//           "scientificNameAuthorship": "",
//           "scientificName": "Furcraea"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Mauritius-hemp",
//           "Giant cabuya",
//           "Green-aloe"
//         ],
//         "scientificName": "Furcraea foetida (L.) Haw."
//       },
//       "gbif": {
//         "id": "2769796"
//       },
//       "powo": {
//         "id": "64429-1"
//       }
//     },
//     {
//       "score": 0.13536,
//       "species": {
//         "scientificNameWithoutAuthor": "Dracaena fragrans",
//         "scientificNameAuthorship": "(L.) Ker Gawl.",
//         "genus": {
//           "scientificNameWithoutAuthor": "Dracaena",
//           "scientificNameAuthorship": "",
//           "scientificName": "Dracaena"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Corn plant",
//           "Fragrant dracaena",
//           "Dracaena"
//         ],
//         "scientificName": "Dracaena fragrans (L.) Ker Gawl."
//       },
//       "gbif": {
//         "id": "5304583"
//       },
//       "powo": {
//         "id": "534207-1"
//       },
//       "iucn": {
//         "id": "144296082",
//         "category": "LC"
//       }
//     },
//     {
//       "score": 0.11944,
//       "species": {
//         "scientificNameWithoutAuthor": "Crinum asiaticum",
//         "scientificNameAuthorship": "L.",
//         "genus": {
//           "scientificNameWithoutAuthor": "Crinum",
//           "scientificNameAuthorship": "",
//           "scientificName": "Crinum"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Amaryllidaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Amaryllidaceae"
//         },
//         "commonNames": [
//           "Mangrove lily",
//           "Grand Crinum",
//           "Poisonbulb"
//         ],
//         "scientificName": "Crinum asiaticum L."
//       },
//       "gbif": {
//         "id": "2853796"
//       },
//       "powo": {
//         "id": "63796-1"
//       }
//     },
//     {
//       "score": 0.01721,
//       "species": {
//         "scientificNameWithoutAuthor": "Rohdea japonica",
//         "scientificNameAuthorship": "(Thunb.) Roth",
//         "genus": {
//           "scientificNameWithoutAuthor": "Rohdea",
//           "scientificNameAuthorship": "",
//           "scientificName": "Rohdea"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Sacred lily-of-China",
//           "Nippon lily"
//         ],
//         "scientificName": "Rohdea japonica (Thunb.) Roth"
//       },
//       "gbif": {
//         "id": "5304302"
//       },
//       "powo": {
//         "id": "540426-1"
//       }
//     },
//     {
//       "score": 0.00533,
//       "species": {
//         "scientificNameWithoutAuthor": "Dracaena reflexa",
//         "scientificNameAuthorship": "Lam.",
//         "genus": {
//           "scientificNameWithoutAuthor": "Dracaena",
//           "scientificNameAuthorship": "",
//           "scientificName": "Dracaena"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Song-of-India",
//           "It IS NOT a Song of India. This is a Tri-Colored Dracaena",
//           "Tri-colored Dracaena"
//         ],
//         "scientificName": "Dracaena reflexa Lam."
//       },
//       "gbif": {
//         "id": "5304436"
//       },
//       "powo": {
//         "id": "534338-1"
//       },
//       "iucn": {
//         "id": "68150169",
//         "category": "LC"
//       }
//     },
//     {
//       "score": 0.00499,
//       "species": {
//         "scientificNameWithoutAuthor": "Agave demeesteriana",
//         "scientificNameAuthorship": "Jacobi",
//         "genus": {
//           "scientificNameWithoutAuthor": "Agave",
//           "scientificNameAuthorship": "",
//           "scientificName": "Agave"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Navajo Princess"
//         ],
//         "scientificName": "Agave demeesteriana Jacobi"
//       },
//       "gbif": {
//         "id": "2766717"
//       },
//       "powo": {
//         "id": "61919-1"
//       }
//     },
//     {
//       "score": 0.00453,
//       "species": {
//         "scientificNameWithoutAuthor": "Dracaena braunii",
//         "scientificNameAuthorship": "Engl.",
//         "genus": {
//           "scientificNameWithoutAuthor": "Dracaena",
//           "scientificNameAuthorship": "",
//           "scientificName": "Dracaena"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Lucky Bamboo",
//           "Bamboo",
//           "Green dragon"
//         ],
//         "scientificName": "Dracaena braunii Engl."
//       },
//       "gbif": {
//         "id": "5304712"
//       },
//       "powo": {
//         "id": "534129-1"
//       }
//     },
//     {
//       "score": 0.0033,
//       "species": {
//         "scientificNameWithoutAuthor": "Dracaena arborea",
//         "scientificNameAuthorship": "(Willd.) Link",
//         "genus": {
//           "scientificNameWithoutAuthor": "Dracaena",
//           "scientificNameAuthorship": "",
//           "scientificName": "Dracaena"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Tree dracaena"
//         ],
//         "scientificName": "Dracaena arborea (Willd.) Link"
//       },
//       "gbif": {
//         "id": "5304485"
//       },
//       "powo": {
//         "id": "534104-1"
//       },
//       "iucn": {
//         "id": "147136700",
//         "category": "LC"
//       }
//     },
//     {
//       "score": 0.00301,
//       "species": {
//         "scientificNameWithoutAuthor": "Beschorneria yuccoides",
//         "scientificNameAuthorship": "K.Koch",
//         "genus": {
//           "scientificNameWithoutAuthor": "Beschorneria",
//           "scientificNameAuthorship": "",
//           "scientificName": "Beschorneria"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Asparagaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Asparagaceae"
//         },
//         "commonNames": [
//           "Yucca-leaved Beschorneria",
//           "Mexican Lily"
//         ],
//         "scientificName": "Beschorneria yuccoides K.Koch"
//       },
//       "gbif": {
//         "id": "2769053"
//       },
//       "powo": {
//         "id": "63213-1"
//       }
//     },
//     {
//       "score": 0.00251,
//       "species": {
//         "scientificNameWithoutAuthor": "Pandanus tectorius",
//         "scientificNameAuthorship": "Parkinson ex Du Roi",
//         "genus": {
//           "scientificNameWithoutAuthor": "Pandanus",
//           "scientificNameAuthorship": "",
//           "scientificName": "Pandanus"
//         },
//         "family": {
//           "scientificNameWithoutAuthor": "Pandanaceae",
//           "scientificNameAuthorship": "",
//           "scientificName": "Pandanaceae"
//         },
//         "commonNames": [
//           "Tahitian Screw-Pine",
//           "Screw pine",
//           "Beach Pandanus"
//         ],
//         "scientificName": "Pandanus tectorius Parkinson ex Du Roi"
//       },
//       "gbif": {
//         "id": "8023236"
//       },
//       "powo": {
//         "id": "895770-1"
//       },
//       "iucn": {
//         "id": "62335",
//         "category": "LC"
//       }
//     }
//   ],
//   "version": "2024-11-19 (7.3)"
// }