import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../../constants.dart';
import 'icon_button_with_caption.dart';

class AddPostTextField extends StatelessWidget {
  const AddPostTextField({
    super.key,
    this.focusNode,
    required this.hintText,
    this.fontSizeRatio = 0.02,
    this.maxLines = 1,
    this.isTitle = false,
    this.hasClearButton = false,
    this.onClearTap = defaultFunction,
    this.onChanged,
  });

  static void defaultFunction() {}

  final String hintText;
  final double fontSizeRatio;
  final int maxLines;
  final bool isTitle;
  final bool hasClearButton;
  final Function() onClearTap;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      minLines: maxLines,
      focusNode: focusNode != null ? focusNode : null,
      style: TextStyle(
          fontSize: ScreenSizeHandler.bigger * fontSizeRatio,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: ScreenSizeHandler.bigger * fontSizeRatio,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
          border: InputBorder.none,
          suffixIcon: hasClearButton
              ? IconButtonWithCaption(
                  icon: Icons.clear,
                  onTap: onClearTap,
                  backgroundColor: kFillingColor,
                  iconRadiusRatio: 0.018,
                  isIconEnabled: true,
                )
              : null),
      onChanged: onChanged,
    );
  }
}
