import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';

import '../../utilities/screen_size_handler.dart';
import 'add_post_clear_button.dart';
import 'poll_days_bottom_sheet.dart';
import 'poll_option_text_field.dart';

class PollEdit extends StatefulWidget {
  const PollEdit(
      {super.key,
      required this.removePoll,
      required this.updateNumOfDays,
      required this.updatePollOptions});

  final Function() removePoll;
  final Function(int, List<TextEditingController>) updatePollOptions;
  final Function(String) updateNumOfDays;

  @override
  State<PollEdit> createState() => _PollEditState();
}

class _PollEditState extends State<PollEdit> {
  int numOfPollOptions = 2;
  String pollDays = "3 days";
  List<TextEditingController> controllers =
      List.generate(2, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSizeHandler.screenWidth * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(bottom: ScreenSizeHandler.screenHeight * .015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Poll ends in  ",
                  style: TextStyle(
                      color: kGreenGrayColor, fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () async {
                    final groupValueNotifier = ValueNotifier<String?>(pollDays);
                    final choice = await showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return PollDaysBottomSheet(
                              groupValueNotifier: groupValueNotifier);
                        });
                    if (choice != null) {
                      setState(() {
                        pollDays = choice;
                        widget.updateNumOfDays(choice);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        pollDays,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                AddPostClearButton(
                    hasBackround: false,
                    buttonSizeRatio: 0.07,
                    onPressed: widget.removePoll)
              ],
            ),
          ),
          for (int i = 1; i <= numOfPollOptions; i++)
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenSizeHandler.screenHeight * 0.02),
              child: PollOptionTextField(
                onChanged: (p0) => widget.updatePollOptions(numOfPollOptions, controllers),
                controller: controllers[i - 1],
                i: i,
                onTap: () {
                  setState(() {
                    controllers.removeAt(i - 1);
                    numOfPollOptions--;
                    widget.updatePollOptions(numOfPollOptions, controllers);
                  });
                },
              ),
            ),
          if (numOfPollOptions < 6)
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenSizeHandler.screenHeight * 0.03),
              child: GestureDetector(
                onTap: () {
                  if (numOfPollOptions < 6) {
                    setState(() {
                      numOfPollOptions++;
                      controllers.add(TextEditingController());
                      widget.updatePollOptions(numOfPollOptions, controllers);
                    });
                  }
                },
                child: Container(
                  height: ScreenSizeHandler.bigger * 0.046,
                  color: Colors.black,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.smaller * 0.035,
                        ),
                        child: const Icon(
                          Icons.add_sharp,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Add Option",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: ScreenSizeHandler.screenHeight * 0.018,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
