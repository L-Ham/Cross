import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class CustomSwitch extends StatelessWidget {
  final bool isSwitched;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.isSwitched,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isSwitched);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: kSwitchAnimationTime),
        width: ScreenSizeHandler.smaller*kSwitchWidthRatio,
        height: ScreenSizeHandler.smaller*kSwitchHeightRatio,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenSizeHandler.smaller*kSwitchBorderRadiusRatio),
          color: isSwitched ? kSwitchOnColor : kSwitchOffColor,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: kSwitchAnimationTime),
          alignment: isSwitched ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: ScreenSizeHandler.smaller*kSwitchCircleSizeRatio,
            height: ScreenSizeHandler.smaller*kSwitchCircleSizeRatio,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}