import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class InvalidLinkError extends StatelessWidget {
  const InvalidLinkError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: kFillingColor),
      width: double.infinity,
      height: ScreenSizeHandler.screenHeight * 0.036,
      child: Center(
        child: Text(
          "Oops, this link isn't valid. Double-check, and try again.",
          style: TextStyle(fontSize: ScreenSizeHandler.bigger * 0.016),
        ),
      ),
    );
  }
}
