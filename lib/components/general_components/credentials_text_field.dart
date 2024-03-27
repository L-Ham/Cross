import 'package:flutter/material.dart';
import '../../utilities/screen_size_handler.dart';
import '../../constants.dart';

class CredentialsTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFocused;
  final bool isValid;
  final ValueChanged<String> onChanged;
  final String text;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isObscure;

  const CredentialsTextField({
    required this.controller,
    required this.isFocused,
    required this.onChanged,
    required this.text,
    required this.isObscure,
    this.suffixIcon,
    this.prefixIcon,
    this.isValid = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: isObscure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
              color: isValid ? Colors.transparent : Colors.red[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: isValid ? Colors.white : Colors.red[200]!),
        ),
        labelText: text,
        labelStyle: TextStyle(
            color: kHintTextColor, fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio),
        fillColor: kFillingColor,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
      ),
    );
  }
}
