import 'package:flutter/material.dart';

class AppField extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;

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
