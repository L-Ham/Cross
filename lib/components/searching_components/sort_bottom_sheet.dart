import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/location_customaization_components/location_customaization_radio_button.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import '../../constants.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({
    super.key,
    required this.groupValueNotifierVal,
    required this.isPosts,
  });

  final String groupValueNotifierVal;
  final bool isPosts;

  @override
  Widget build(BuildContext context) {
    final groupValueNotifier = ValueNotifier<String?>(groupValueNotifierVal);
    List<String> vals = isPosts
        ? ["Most relevant", "Hot", "Top", "New", "Comment count"]
        : ["Most relevant", "Top", "New"];

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
                    "Sort",
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.bigger * 0.022,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      radius: ScreenSizeHandler.bigger * 0.024,
                      child: Icon(
                        Icons.close,
                        size: ScreenSizeHandler.bigger * 0.04,
                      ),
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
