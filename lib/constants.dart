import 'dart:ui';
import 'package:flutter/material.dart';

const Color kBackgroundColor = Color.fromARGB(255, 20, 20, 20);
const Color kFillingColor = Color.fromARGB(255, 40, 40, 40);
const Color kHintTextColor = Color.fromARGB(255, 122, 122, 122);

const double kSettingsLeadingIconRatio = 0.07;
const double kSettingsTileTextRatio = 0.04;
const double kSettingsTrailingIconRatio = 0.075;

TextStyle kSettingsIconTextStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle kSettingsConnectedAccountsTextStyle = const TextStyle(
  color: Colors.blue,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);
