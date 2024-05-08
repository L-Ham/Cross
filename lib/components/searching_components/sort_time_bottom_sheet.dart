import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/location_customaization_components/location_customaization_radio_button.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import '../../constants.dart';

class SortTimeBottomSheet extends StatelessWidget {
  const SortTimeBottomSheet({
    super.key,
    required this.groupValueNotifierVal,
  });

  final String groupValueNotifierVal;

  @override
  Widget build(BuildContext context) {
    final groupValueNotifier = ValueNotifier<String?>(groupValueNotifierVal);
    List<String> vals = [
      "All time",
      "Past hour",
      "Today",
      "Past week",
      "Past month",
      "Past year"
    ];
    return Container(
      color: kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenSizeHandler.screenHeight * 0.02,
                  left: ScreenSizeHandler.screenWidth * 0.04,
                  right: ScreenSizeHandler.screenWidth * 0.04,
                  bottom: ScreenSizeHandler.screenHeight * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Time",
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.bigger * 0.022,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    radius: ScreenSizeHandler.bigger * 0.024,
                    child: Icon(
                      Icons.close,
                      size: ScreenSizeHandler.bigger * 0.04,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.grey[800],
              thickness: 1,
            ),
            for (String val in vals)
              LocationCustomizationRadioButtonTile(
                  value: val, groupValueNotifier: groupValueNotifier),
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.03,
            )
          ],
        ),
      ),
    );
  }
}
