import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/favoritos/db-helper.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {

    // Verifica usuário logado
    Future<Usuario> futureUsuario = Usuario.get();

    // Inicializar o banco de dados
    Future futureBd = DatabaseHelper.getInstance().db;
    Future.wait([futureBd, futureUsuario]).then((List values) {
      Usuario user = values[1];

      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
