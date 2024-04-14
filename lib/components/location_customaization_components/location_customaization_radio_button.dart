import 'package:flutter/material.dart';
import '../../utilities/screen_size_handler.dart';

class LocationCustomizationRadioButtonTile extends StatelessWidget {
  final String value;
  final ValueNotifier<String?> groupValueNotifier;

  const LocationCustomizationRadioButtonTile({
    required this.value,
    required this.groupValueNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        groupValueNotifier.value = value;
        Navigator.pop(context, value);
      },
      child: ValueListenableBuilder<String?>(
        valueListenable: groupValueNotifier,
        builder: (context, groupValue, child) {
          return SizedBox(
            height: ScreenSizeHandler.screenHeight * 0.058,
            child: ListTileTheme(
              horizontalTitleGap: ScreenSizeHandler.screenWidth * 0.025,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                title: Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeHandler.bigger * 0.023,
                  ),
                ),
                leading: Transform.scale(
                  scale: 1.2,
                  child: Radio(
                    activeColor: Colors.white,
                    value: value,
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValueNotifier.value = value;
                      Navigator.pop(context, value);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
