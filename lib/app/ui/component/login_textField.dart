// ignore: file_names
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(222, 175, 172, 172)),
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(8), left: Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 82, 81, 81)),
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(8), left: Radius.circular(8)),
          ),
          fillColor: const Color.fromARGB(239, 255, 255, 255),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
