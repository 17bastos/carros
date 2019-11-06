import 'package:flutter/material.dart';

class AppField extends StatelessWidget {
  @override
  String label;
  String hint;
  bool obscureText;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyBoardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyBoardType,
      validator: validator,
      obscureText: obscureText,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      textInputAction: textInputAction,
      decoration: InputDecoration(
          labelText: label
          ,hintText: hint
          ,border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16)
          )
      ),
    );
  }

  AppField(this.label, this.hint,
      {this.obscureText = false,
      this.controller,
      this.validator,
      this.keyBoardType,
      this.textInputAction,
      this.focusNode,
      this.nextFocus});
}
