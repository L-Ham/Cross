import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  FocusNode? focusNode = FocusNode();

  CredentialsTextField({
    required this.controller,
    required this.isFocused,
    required this.onChanged,
    required this.text,
    required this.isObscure,
    this.suffixIcon,
    this.prefixIcon,
    this.isValid = true,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return TextField(
      focusNode: focusNode??FocusNode(),
      inputFormatters: [
    FilteringTextInputFormatter.deny(RegExp(r'\s')),],
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
        contentPadding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.smaller * kButtonWidthRatio,
            horizontal: ScreenSizeHandler.smaller * kButtonWidthRatio),
        labelStyle: TextStyle(
          color: kHintTextColor,
          fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
        ),
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
