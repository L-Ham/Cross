import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class AddPostClearButton extends StatelessWidget {
  const AddPostClearButton(
      {super.key,
      required this.onPressed,
      this.buttonSizeRatio = 0.09,
      this.hasBackround = true});

  final Function() onPressed;
  final double buttonSizeRatio;
  final bool hasBackround;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              hasBackround ? Icons.cancel : Icons.clear,
              color:
                  hasBackround ? Colors.black.withOpacity(0.5) : Colors.white,
              size: ScreenSizeHandler.smaller * buttonSizeRatio,
            ),
            onPressed: onPressed),
      ],
    );
  }
}
