import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_radio_button_tile.dart';

class ChangeGenderBottomSheet extends StatefulWidget {
  const ChangeGenderBottomSheet({super.key, required this.initialValue});

  final String initialValue;

  @override
  State<ChangeGenderBottomSheet> createState() =>
      _ChangeGenderBottomSheetState();
}

class _ChangeGenderBottomSheetState extends State<ChangeGenderBottomSheet> {
  final groupValueNotifier = ValueNotifier<String?>(null);

  @override
  void initState (){
    super.initState();
    groupValueNotifier.value = widget.initialValue;
  }
  Widget build(BuildContext context) {
    return Container(
      color: kFillingColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  print(groupValueNotifier.value);
                  Navigator.pop(context, groupValueNotifier.value);
                },
                child: Text(
                  "Done",
                  style: kSettingsConnectedAccountsTextStyle,
                ),
              )
            ],
          ),
          SettingsRadioButtonTile(
            groupValueNotifier: groupValueNotifier,
            value: "Male",
          ),
          SettingsRadioButtonTile(
            groupValueNotifier: groupValueNotifier,
            value: "Female",
          ),
          SettingsRadioButtonTile(
            groupValueNotifier: groupValueNotifier,
            value: "Others",
          )
        ],
      ),
    );
  }
}
