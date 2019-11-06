import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String texto;
  Function onPressed;

  AppButton(this.texto, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          texto,
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        onPressed: onPressed,
      ),
    );
  }

}
