import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.onTap,
    required this.child,
    this.buttonColor = kFillingColor,
    required this.buttonHeightRatio,
    required this.buttonWidthRatio,
    this.borderColor,
  });

  final Function() onTap;
  final Widget child;
  final Color buttonColor;
  final Color? borderColor;
  final double buttonHeightRatio;
  final double buttonWidthRatio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ScreenSizeHandler.bigger * buttonHeightRatio,
        width: ScreenSizeHandler.bigger * buttonWidthRatio,
        decoration: BoxDecoration(
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          color: buttonColor,
          borderRadius: BorderRadius.circular(30), // Add rounded border
        ),
        child: Center(child: child),
      ),
    );
  }
}
