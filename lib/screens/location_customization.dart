import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import '../countries.dart';
import '../utilities/screen_size_handler.dart';
import '../components/location_customaization_components/location_customaization_radio_button.dart';

class LocationCustomization extends StatefulWidget {
  const LocationCustomization({super.key, required this.initialValue});

  final String initialValue;

  @override
  State<LocationCustomization> createState() => _LocationCustomizationState();
}

class _LocationCustomizationState extends State<LocationCustomization> {
  final groupValueNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    groupValueNotifier.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        centerTitle: true,
        title: Text(
          'Select Location',
          style: kPageTitleStyle.copyWith(
              fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (String country in countries)
              LocationCustomizationRadioButtonTile(
                groupValueNotifier: groupValueNotifier,
                value: country,
              ),
          ],
        ),
      ),
    );
  }
}
