import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class CommunityRuleTile extends StatefulWidget {
  const CommunityRuleTile({
    super.key,
    required this.ruleNum,
    required this.ruleTitle,
    required this.ruleDescription,
  });

  final int ruleNum;
  final String ruleTitle;
  final String ruleDescription;

  @override
  State<CommunityRuleTile> createState() => _CommunityRuleTileState();
}

class _CommunityRuleTileState extends State<CommunityRuleTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.screenHeight * 0.014),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.ruleNum}. ${widget.ruleTitle}",
                  style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.0177,
                      fontWeight: FontWeight.w400),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                )
              ],
            ),
            if (isExpanded)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSizeHandler.screenHeight * 0.013),
                  child: Text(
                    widget.ruleDescription,
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.0167,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
