import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import '../utilities/screen_size_handler.dart';

class LogoTextAppBar extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const LogoTextAppBar({required this.onTap, super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      centerTitle: true,
      backgroundColor: kBackgroundColor,
      title: Hero(
        tag: 'logo',
        child: Image(
          image: const AssetImage('assets/images/elham_final_logo.png'),
          height: ScreenSizeHandler.screenHeight * 0.12,
          width: ScreenSizeHandler.screenWidth * 0.12,
        ),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: ScreenSizeHandler.screenHeight * 0.015,
            right: ScreenSizeHandler.screenWidth * 0.02,
          ),
          child: Container(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: onTap,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: ScreenSizeHandler.smaller * 0.04,
                  fontWeight: FontWeight.bold,
                  color: kHintTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
