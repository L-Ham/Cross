import 'package:flutter/material.dart';

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
    return Switch(
      value: isSwitched,
      thumbColor: MaterialStateProperty.all(Colors.white),
      activeColor: Colors.blueAccent,
      onChanged: onChanged,
    );
  }
}