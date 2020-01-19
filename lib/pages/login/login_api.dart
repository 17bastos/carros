import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v1/login';

      final params = {"username": login, "password": senha};

      Map<String, String> headers = {"Content-Type": "application/json"};

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);
      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(result: user);
      } else {
        return ApiResponse.error(msg: mapResponse["error"]);
      }
    } catch (error, exception) {
      print("Erro no login $error > $exception");
      return ApiResponse.error(msg: "Não foi possível realizar o login");
    }
  }
}
