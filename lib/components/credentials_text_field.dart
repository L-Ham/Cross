import 'package:flutter/material.dart';
import '../utilities/screen_size_handler.dart';
import '../constants.dart';

class CredentialsTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFocused;
  final ValueChanged<String> onChanged;
  final String text;
  final Widget? suffixIcon;
  final bool isObscure;

  const CredentialsTextField({
    required this.controller,
    required this.isFocused,
    required this.onChanged,
    required this.text,
    required this.isObscure,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      onChanged: onChanged,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: text,
        labelStyle: const TextStyle(color: kHintTextColor,fontSize: ScreenSizeHandler.smaller * 0.035),),
        fillColor: kFillingColor,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(color: Colors.white,fontSize: ScreenSizeHandler.smaller * 0.035,),
    );
  }
}

