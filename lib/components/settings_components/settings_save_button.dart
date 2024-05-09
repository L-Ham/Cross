import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class SettingsSaveButton extends StatelessWidget {
  const SettingsSaveButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.isUnderlined = true, 
  });

  final Function() onPressed;
  final bool isEnabled;
  final bool isUnderlined;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.045),
      child: IconButton(
        icon: Text(
          'SAVE',
          style: TextStyle(
            color: isEnabled ? Colors.blue : Colors.grey,
            fontWeight: FontWeight.w700,
            decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
            fontSize: ScreenSizeHandler.bigger * 0.016,
            decorationColor: isEnabled ? Colors.blue : Colors.grey,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
