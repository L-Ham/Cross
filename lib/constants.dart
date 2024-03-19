import 'package:flutter/material.dart';

const kPageTitleFontSizeHeightRatio = 0.03;
const kPageSubtitleFontSizeHeightRatio = 0.02;
const kCommunityNameMinLength = 3;
const kCommunityNameMaxLength = 21;
const kCommunityTypeDescriptionHeightRatio = 0.018;
const kCreateCommunityButtonTextHeightRatio = 0.033;
const kCreateCommunityButtonHeightRatio = 0.075;
const kErrorTextHeightRatio = 0.018;

const Color kBackgroundColor = Color.fromARGB(255, 20, 20, 20);
const Color kFillingColor = Color.fromARGB(255, 40, 40, 40);
const Color kHintTextColor = Color.fromARGB(255, 122, 122, 122);

const double kSettingsLeadingIconRatio = 0.035;
const double kSettingsTileTextRatio = 0.0205;
const double kSettingsTileSubtextRatio = 0.0175;
const double kSettingsTrailingIconRatio = 0.041;
const double kSettingsSegmentTextRatio = 0.0187;
const double kAppBarTitleFontSizeRatio = 0.025;
const double kSettingsTextRatio = 0.019;
const double kInteractiveTextHeightRatio = 0.02;

const kPageTitleStyle =
    TextStyle(fontWeight: FontWeight.w500, color: Colors.white);

TextStyle kSettingsIconTextStyle = const TextStyle(
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
TextStyle kInteractiveTextStyle = const TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

TextStyle kSettingsSegmentTileTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white38,
);

TextStyle kSettingsSubHeaderTextStyle =
    const TextStyle(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle kSettingsBodyTextStyle =
    const TextStyle(color: Colors.white, fontWeight: FontWeight.w400);
