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
  

  // ignore: use_key_in_widget_constructors
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSizeHandler.screenWidth * 0.04,
        vertical: ScreenSizeHandler.screenHeight * 0.01,
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
          labelStyle: TextStyle(
              color: kHintTextColor,
              fontSize: ScreenSizeHandler.smaller * 0.035),
          fillColor: kFillingColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          suffixIcon: suffixIcon,
        ),
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenSizeHandler.smaller * 0.035,
        ),
      ),
    );
  }
}
