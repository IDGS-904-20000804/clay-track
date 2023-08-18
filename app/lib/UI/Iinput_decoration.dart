import 'package:flutter/material.dart';

const theme = Color.fromRGBO(17, 90, 133, 1);

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintTex,
    required String labelTex,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: theme),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: theme, width: 2),
        ),
        hintText: hintTex,
        labelText: labelTex,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: theme) : null);
  }
}
