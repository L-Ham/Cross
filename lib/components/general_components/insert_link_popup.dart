import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/utilities/ensure_http.dart';

import '../../constants.dart';
import '../../utilities/is_valid_url.dart';
import '../../utilities/screen_size_handler.dart';

class InsertLinkPopUp extends StatefulWidget {
  const InsertLinkPopUp({
    super.key,
  });

  @override
  State<InsertLinkPopUp> createState() => _InsertLinkPopUpState();
}

class _InsertLinkPopUpState extends State<InsertLinkPopUp> {
  TextEditingController urlNameController = TextEditingController();

  TextEditingController urlLinkController = TextEditingController();

  ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    urlNameController.addListener(updateButtonState);
    urlLinkController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    urlNameController.removeListener(updateButtonState);
    urlLinkController.removeListener(updateButtonState);
    super.dispose();
  }

  void updateButtonState() {
    isButtonEnabled.value =
        urlNameController.text.isNotEmpty && isValidUrl(urlLinkController.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Add this line
      ),
      backgroundColor: kBackgroundColor,
      shadowColor: kBackgroundColor,
      surfaceTintColor: kBackgroundColor,
      title: Text(
        'Insert a link',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenSizeHandler.bigger * 0.024,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: urlNameController,
              decoration: InputDecoration(
                  hintText: 'Name',
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(fontSize: ScreenSizeHandler.bigger * 0.018)),
            ),
            TextFormField(
              controller: urlLinkController,
              decoration: InputDecoration(
                  hintText: 'Link',
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(fontSize: ScreenSizeHandler.bigger * 0.018)),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButton(
                    onTap: () {
                      Navigator.of(context).pop();
                      urlLinkController.clear();
                      urlNameController.clear();
                    },
                    buttonWidthRatio: 0.14,
                    buttonHeightRatio: 0.065,
                    buttonColor: kBackgroundColor,
                    child: const Text('Cancel'),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isButtonEnabled,
                    builder:
                        (BuildContext context, bool isEnabled, Widget? child) {
                      return RoundedButton(
                        onTap: () {
                          if (isEnabled) {
                            urlLinkController.text =
                                ensureHttp(urlLinkController.text);
                            Navigator.pop(
                              context,
                              {
                                'name': urlNameController.text,
                                'link': urlLinkController.text,
                              },
                            );
                            urlLinkController.clear();
                            urlNameController.clear();
                          }
                        },
                        buttonWidthRatio: 0.14,
                        buttonHeightRatio: 0.06,
                        buttonColor: Colors.blue,
                        child: Text(
                          'Insert',
                          style: TextStyle(
                            color: isEnabled
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
