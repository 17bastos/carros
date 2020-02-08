import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/cadastro/cadastro_page.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/widgets/firebase.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _focusSenha = FocusNode();
  final _bloc = LoginBloc();
  var _formKey = GlobalKey<FormState>();
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    initFcm();
    RemoteConfig.instance.then((remoteConfig) {
      remoteConfig.fetch(expiration: const Duration(hours: 5));
      remoteConfig.activateFetched();
      print('welcome message: ' + remoteConfig.getString('mensagem'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carros"),
        ),
        body: _body());
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppField(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppField("Senha", "Digite a senha",
                controller: _tSenha,
                keyBoardType: TextInputType.number,
                validator: _validateSenha,
                obscureText: true,
                focusNode: _focusSenha),
            SizedBox(
              height: 20,
            ),
            AppButton(
              "Login",
              showProgress: _showProgress,
              onPressed: _onClickLogin,
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: GoogleSignInButton(
                onPressed: _onClickGoogle,
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: _onClickCadastrar,
                child: Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      decoration: TextDecoration.underline
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    var formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;
      print(user);
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _showProgress = false;
    });
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }

    if (text.length < 3) {
      return "A senha deve ter pelo menos 3 digitos";
    }

    return null;
  }

  _onClickGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();

    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
  }

  _onClickCadastrar() async {
    push(context, CadastroPage(),replace:true);
  }
}
