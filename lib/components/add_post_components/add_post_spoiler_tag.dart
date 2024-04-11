import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class AddPostSpoilerTag extends StatelessWidget {
  const AddPostSpoilerTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: ScreenSizeHandler.screenWidth * kTagSpacingWidthRatio),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(Icons.warning),
          Text('SPOILER',
              style: kTagsTextStyle.copyWith(
                  fontSize: ScreenSizeHandler.bigger * kTagTextSizeRatio))
        ],
      ),
    );
  }
}
