import 'package:flutter/material.dart';

class SettingsRadioButtonTile extends StatelessWidget {
  final String value;
  final ValueNotifier<String?> groupValueNotifier;

  const SettingsRadioButtonTile({
    super.key,
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
            visualDensity: VisualDensity.compact,
            title: Row(
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(unselectedWidgetColor: Colors.white),
                  child: Radio(
                    activeColor: Colors.white,
                    value: value,
                    groupValue: groupValue,
                    onChanged: (value) {
                      groupValueNotifier.value = value;
                    },
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
