import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';
import '../general_components/rounded_button.dart';
import '../location_customaization_components/location_customaization_radio_button.dart';

class PollDaysBottomSheet extends StatelessWidget {
  const PollDaysBottomSheet({
    super.key,
    required this.groupValueNotifier,
  });

  final ValueNotifier<String?> groupValueNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: ScreenSizeHandler.screenHeight * 0.015),
      color: kBackgroundColor,
      child: Wrap(
        children: [
          for (int i = 7; i > 0; i--)
            LocationCustomizationRadioButtonTile(
              groupValueNotifier: groupValueNotifier,
              value: "$i days",
            ),
          Center(
            child: RoundedButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonHeightRatio: 0.045,
                buttonWidthRatio: 0.43,
                child: const Text(
                  "Close",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline),
                )),
          )
        ],
      ),
    );
  }
}
