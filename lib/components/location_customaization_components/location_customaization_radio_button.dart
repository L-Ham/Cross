import 'package:flutter/material.dart';

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
      },
      child: ValueListenableBuilder<String?>(
        valueListenable: groupValueNotifier,
        builder: (context, groupValue, child) {
          return ListTile(
            title: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
            leading: Radio(
              activeColor: Colors.white,
              value: value,
              groupValue: groupValue,
              onChanged: (value) {
                groupValueNotifier.value = value;
                Navigator.pop(context, value);
              },
            ),
          );
        },
      ),
    );
  }
}
