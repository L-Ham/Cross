import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_radio_button_tile.dart';
import '../countries.dart';
import '../components/location_customaization_components/location_customaization_radio_button.dart';

class LocationCustomization extends StatefulWidget {
  const LocationCustomization({Key? key, required this.initialValue});

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
      appBar: AppBar(
        title: Center(
          child: Text(
            'Select Location',
            style: kPageTitleStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height *
                  kPageTitleFontSizeHeightRatio,
            ),
          ),
        ),
      ),
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
