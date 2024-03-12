import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart'; 

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFocused;
  final ValueChanged<String> onChanged;
  final String text;
  final Widget? suffixIcon;
  final bool isObscure;

  const LoginTextField({
    required this.controller,
    required this.isFocused,
    required this.onChanged,
    required this.text,
    required this.isObscure,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        obscureText: isObscure,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: text,
          labelStyle: TextStyle(color: kHintTextColor),
          fillColor: kFillingColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: suffixIcon,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}