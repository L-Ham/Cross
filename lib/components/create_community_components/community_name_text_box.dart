import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class CommunityNameTextBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function() onClear;

  const CommunityNameTextBox({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[900],
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        prefixText: 'r/',
        hintText: 'Community_name',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: ScreenSizeHandler.smaller*kButtonSmallerFontRatio,
        ),
        suffixText: '${21 - controller.text.length}',
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: CircleAvatar(
                  radius: 8.0,
                  backgroundColor:
                      Colors.grey[800],
                  child: Icon(Icons.clear,
                      size: 12.0,
                      color: Colors.black),
                ),
                onPressed: onClear,
              ),
      ),
      onChanged: onChanged,
    );
  }
}
