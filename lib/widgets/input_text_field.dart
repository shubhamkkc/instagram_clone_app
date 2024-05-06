import 'package:flutter/material.dart';
import 'package:instagram_clone_app/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPass;
  final TextInputType keyboardType;
  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPass = false,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      obscureText: isPass,
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: mobileSearchColor,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          hintText: hintText),
    );
  }
}
