import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';

import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class EllipsisTile extends StatelessWidget {
  final String tileText;
  final IconData tileIcon;

  EllipsisTile({required this.tileText, required this.tileIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenSizeHandler.screenHeight * 0.015,
          horizontal: ScreenSizeHandler.screenWidth * 0.002),
      child: Row(
        children: [
          Icon(
            tileIcon,
            color: Colors.white,
          ),
          SizedBox(
            width: ScreenSizeHandler.screenWidth * 0.03,
          ),
          Text(
            tileText,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenSizeHandler.bigger * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
