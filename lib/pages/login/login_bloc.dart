import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class  LoginBloc {
  Future<ApiResponse> login(String login, String senha) async {
    //ApiResponse response = await LoginApi.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha);
    return response;
  }
}