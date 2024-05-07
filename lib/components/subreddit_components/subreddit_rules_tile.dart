import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RulesTile extends StatefulWidget {
  final String ruleTitle;
  final String ruleDescription;
  final index;

  RulesTile(
      {required this.ruleTitle,
      required this.ruleDescription,
      required this.index});

  @override
  State<RulesTile> createState() => _RulesTileState();
}

class _RulesTileState extends State<RulesTile> {
  bool droppeddown = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSizeHandler.screenHeight * 0.017,
        horizontal: ScreenSizeHandler.screenWidth * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${widget.index}. ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSizeHandler.bigger * 0.018,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                widget.ruleTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSizeHandler.bigger * 0.018,
                ),
                textAlign: TextAlign.left,
              ),
              Spacer(),
              GestureDetector(
                child: Container(
                  width: ScreenSizeHandler.screenWidth * 0.1,
                  height: ScreenSizeHandler.screenHeight * 0.03,
                  child: Icon(
                    !droppeddown
                        ? FontAwesomeIcons.chevronDown
                        : FontAwesomeIcons.chevronUp,
                    color: Colors.white,
                    size: ScreenSizeHandler.bigger * 0.015,
                  ),
                ),
                onTap: () {
                  setState(() {
                    droppeddown = !droppeddown;
                  });
                },
              ),
            ],
          ),
          if (droppeddown)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.ruleDescription.split('\n').map((rule) {
                // Remove leading '- ' and surrounding whitespace
                rule = rule.replaceAll(RegExp(r'^\s*[-]+\s*'), '');
                // Remove bold formatting (double asterisks)
                rule = rule.replaceAll(RegExp(r'\*\*'), '');
                // Trim whitespace
                rule = rule.trim();
                // Add bullet point before each rule
                rule = '• $rule';
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.04,
                  ),
                  child: Text(
                    rule,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.bigger * 0.018,
                    ),
                    textAlign: TextAlign.left,
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
