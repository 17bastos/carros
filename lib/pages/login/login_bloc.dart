import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class  LoginBloc {
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    ApiResponse response = await LoginApi.login(login, senha);
    return response;
  }
}