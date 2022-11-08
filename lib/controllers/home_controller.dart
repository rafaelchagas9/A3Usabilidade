import 'dart:convert';

import 'package:olimpiadas/models/esportes.dart';

import 'package:http/http.dart' as http;
import 'package:olimpiadas/models/esportes.dart';

class HomeController {
  List<Esporte> esportes = [];

  Future start() async {
    var url = Uri.https(
        "raw.githubusercontent.com", "/rafaelchagas9/JSON/main/esportes.json");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var esportes = Esporte.fromJson(json);
    return esportes;
  }
}
