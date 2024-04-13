import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class SettingsTextField extends StatelessWidget {
  const SettingsTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscured = false,
    this.isDisconnectScreen = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isObscured;
  final bool isDisconnectScreen;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHandler.bigger * 0.057,
      child: TextField(
        style: TextStyle(
          fontSize: ScreenSizeHandler.bigger * 0.017,
          color: Colors.white,
        ),
        cursorColor: kCursorColor,
        obscureText: isObscured,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: isDisconnectScreen
              ? IconButton(
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: onTap)
              : null,
          contentPadding: EdgeInsets.only(
              bottom: ScreenSizeHandler.bigger * 0.013,
              left: ScreenSizeHandler.bigger * 0.017),
          fillColor: kFillingColor,
          filled: true,
          border: isDisconnectScreen
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // This makes the border rounded
                  borderSide: BorderSide.none,
                )
              : InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: ScreenSizeHandler.bigger * 0.017,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
