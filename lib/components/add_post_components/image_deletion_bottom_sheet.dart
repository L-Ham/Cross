import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';
import 'bottom_sheet_big_button.dart';

class ImageDeletionBottomSheet extends StatelessWidget {
  const ImageDeletionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.05),
      child: Wrap(
        children: <Widget>[
          BottomSheetBigButton(
            title: "Delete current Image",
            textColor: Colors.red[400]!,
            onTap: () {
              Navigator.pop(context, "current");
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey[800],
          ),
          BottomSheetBigButton(
            title: "Delete all Images",
            textColor: Colors.red[400]!,
            onTap: () {
              Navigator.pop(context, "all");
            },
          ),
          Container(
            color: Colors.transparent,
            height: ScreenSizeHandler.screenHeight * 0.01,
          ),
          BottomSheetBigButton(
            title: "Cancel",
            textColor: Colors.blue,
            isBold: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
