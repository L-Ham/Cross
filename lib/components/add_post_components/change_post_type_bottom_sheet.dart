import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';
import '../general_components/rounded_button.dart';

class ChangePostTypeBottomSheet extends StatelessWidget {
  const ChangePostTypeBottomSheet({
    super.key,
    this.titleText = "Change Post Type",
    this.bodyText = "Some of your post will be deleted if you continue.",
    this.leftButtonText = "Cancel",
    this.rightButtonText = "Continue",
  });

  final String titleText;
  final String bodyText;
  final String leftButtonText;
  final String rightButtonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kFillingColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Wrap(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.025),
              child: Text(
                titleText,
                style: TextStyle(
                    fontSize: ScreenSizeHandler.bigger * 0.026,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenSizeHandler.bigger * 0.018,
                  horizontal: ScreenSizeHandler.screenWidth * 0.05),
              child: Text(
                bodyText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenSizeHandler.bigger * 0.0175),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: ScreenSizeHandler.bigger * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButton(
                  onTap: () {
                    Navigator.pop(context, "cancel");
                  },
                  buttonColor: kFillingColor,
                  buttonHeightRatio: 0.053,
                  buttonWidthRatio: 0.2,
                  child: Text(
                    leftButtonText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: ScreenSizeHandler.bigger * 0.018),
                  ),
                ),
                RoundedButton(
                  onTap: () {
                    Navigator.pop(context, "continue");
                  },
                  buttonColor: Colors.red[600]!,
                  buttonHeightRatio: 0.053,
                  buttonWidthRatio: 0.2,
                  child: Text(
                    rightButtonText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.bigger * 0.018,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
