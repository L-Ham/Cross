import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class AddPostBrandAffiliateTag extends StatelessWidget {
  const AddPostBrandAffiliateTag({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "BRAND AFFILIATE",
      style: kTagsTextStyle.copyWith(
          fontSize: ScreenSizeHandler.bigger * kTagTextSizeRatio,
          color: kGreenGrayColor),
    );
  }
}
