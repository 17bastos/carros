import 'dart:convert';

import 'carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    try {

    } catch (error) {
      print(error);
    }
    var url = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
    var response = await http.get(url);
    List list = json.decode(response.body);

    return list.map<Carro>((map) => Carro.fromJson(map)).toList();
  }
}