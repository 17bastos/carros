import 'dart:convert' as convert;
import 'dart:io';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/upload_api.dart';

import 'carro.dart';
import 'package:carros/utils/http_helper.dart' as http;

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo';
      var response = await http.get(url);
      List list = convert.json.decode(response.body);

      List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

      return carros;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  static Future<ApiResponse<bool>> save(Carro c, File file) async {

    if (file != null) {
      final response = await UploadApi.upload(file);
      if(response.ok) {
        c.urlFoto = response.result;
      }
    }

    var url = 'http://carros-springboot.herokuapp.com/api/v1/carros';
    if(c.id != null) {
      url += "/${c.id}";
    }

    var response = await (
      c.id == null ?
      http.post(url, body: c.toJson()) :
      http.put(url, body: c.toJson())
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return ApiResponse.ok(result: true);
    }

    if (response.body == null || response.body.isEmpty) {
      return ApiResponse.error(msg: "Não foi poassível salvar o carro!");
    }

    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(msg: mapResponse["error"]);
  }

  static Future<ApiResponse<bool>> delete(Carro c) async {
    var url = 'http://carros-springboot.herokuapp.com/api/v1/carros/${c.id}';

    var response = await http.delete(url);

    if (response.statusCode == 200) {
      return ApiResponse.ok(result: true);
    }

    if (response.body == null || response.body.isEmpty) {
      return ApiResponse.error(msg: "Não foi poassível excluir o carro!");
    }

    Map mapResponse = convert.json.decode(response.body);
    return ApiResponse.error(msg: mapResponse["error"]);
  }
}