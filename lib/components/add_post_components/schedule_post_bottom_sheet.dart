import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/add_post_components/schedule_post_tile.dart';

import '../../constants.dart';
import '../../utilities/format_date_time.dart';
import '../../utilities/screen_size_handler.dart';
import '../general_components/custom_switch.dart';
import '../general_components/rounded_button.dart';

class SchedulePostBottomSheet extends StatefulWidget {
  const SchedulePostBottomSheet({
    super.key,
  });

  @override
  State<SchedulePostBottomSheet> createState() =>
      _SchedulePostBottomSheetState();
}

class _SchedulePostBottomSheetState extends State<SchedulePostBottomSheet> {
  bool isSwitched = false;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String getWeekday(DateTime date) {
  const weekDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return weekDays[date.weekday - 1];
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.04),
      color: kBackgroundColor,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.screenHeight * 0.03),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: ScreenSizeHandler.bigger * 0.04,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.02),
                  child: Text(
                    "Schedule Post",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.022,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                RoundedButton(
                  buttonColor: kSwitchOnColor,
                  onTap: () {
                    Navigator.pop(context, {
                      "selectedDate": selectedDate,
                      "selectedTime": selectedTime
                    });
                  },
                  buttonHeightRatio: 0.042,
                  buttonWidthRatio: 0.07,
                  child: const Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SchedulePostTile(
              leadingText: "Starts on date",
              trailingText: formatDate(selectedDate),
              onTap: () {
                selectDate(context);
              }),
          SchedulePostTile(
              leadingText: "Starts at time",
              trailingText: formatTime(selectedTime),
              onTap: () {
                selectTime(context);
              }),
          SchedulePostTile(
              leadingText: "Repeat weekly on ${getWeekday(selectedDate)}",
              isText: false,
              trailingWidget: CustomSwitch(
                  isSwitched: isSwitched,
                  onChanged: (val) {
                    setState(() {
                      isSwitched = val;
                    });
                  }),
              onTap: () {
                setState(() {
                  isSwitched = !isSwitched;
                });
              })
        ],
      ),
    );
  }
}
