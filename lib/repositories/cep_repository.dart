import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/cep.dart';

class CepRepository {
  Future<Cep?> buscarCEP(String cep) async {
    var url = 'https://viacep.com.br/ws/$cep/json/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      return null;
    }
    final responseMap = jsonDecode(response.body);

    if (responseMap.containsKey('erro')) {
      return null;
    } else {
      return Cep.fromMap(responseMap);
    }
  }
}
