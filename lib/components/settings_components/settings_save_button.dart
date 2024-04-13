import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class SettingsSaveButton extends StatelessWidget {
  const SettingsSaveButton({
    super.key,
    required this.onPressed
  });

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.045),
      child: IconButton(
        icon: Text(
          'Save',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            fontSize: ScreenSizeHandler.bigger * 0.018,
          ),
        ),
        onPressed: () {
          // TODO: Implement the done functionality
        },
      ),
    );
  }
}
