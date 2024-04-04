// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class BlockedAccountTile extends StatefulWidget {
  final String imagePath;
  final String username;
  bool isAccountBlocked;

  BlockedAccountTile({
    required this.imagePath,
    required this.username,
    required this.isAccountBlocked,
  });

  @override
  State<BlockedAccountTile> createState() => _BlockedAccountTileState();
}

class _BlockedAccountTileState extends State<BlockedAccountTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.035,
          vertical: ScreenSizeHandler.screenHeight * 0.012),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: ScreenSizeHandler.bigger * 0.0165,
                foregroundImage: AssetImage(widget.imagePath),
              ),
              SizedBox(
                width: ScreenSizeHandler.screenWidth * 0.04,
              ),
              Text(
                widget.username,
                style: TextStyle(
                  fontSize: ScreenSizeHandler.bigger *
                      kPageSubtitleFontSizeHeightRatio,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          if (widget.isAccountBlocked)
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.035,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    widget.isAccountBlocked = false;
                  });
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(
                    ScreenSizeHandler.screenWidth * 0.25,
                    0,
                  )),
                  side: MaterialStateBorderSide.resolveWith((states) {
                    return BorderSide(
                        color: kBlockButtonColor,
                        width: ScreenSizeHandler.screenWidth * 0.004);
                  }),
                ),
                child: Text(
                  'Unblock',
                  style: TextStyle(
                    color: kBlockButtonColor,
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenSizeHandler.bigger * 0.0165,
                  ),
                ),
              ),
            ),
          if (!widget.isAccountBlocked)
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.035,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.isAccountBlocked = true;
                  });
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(
                    ScreenSizeHandler.screenWidth * 0.24,
                    0,
                  )),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => kBlockButtonColor,
                  ),
                ),
                child: Text(
                  'Block',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeHandler.bigger * 0.017,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
