import 'dart:convert';

import 'package:carros/pages/favoritos/carro-dao.dart';
import 'package:carros/pages/login/usuario.dart';

import 'carro.dart';
import 'package:http/http.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    try {

      Usuario user = await Usuario.get();

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      var url = 'http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';
      var response = await http.get(url, headers: headers);
      List list = json.decode(response.body);

      List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

      return list.map<Carro>((map) => Carro.fromJson(map)).toList();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}