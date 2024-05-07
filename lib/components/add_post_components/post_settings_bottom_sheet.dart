import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/format_date_time.dart';
import '../../utilities/screen_size_handler.dart';
import 'schedule_post_bottom_sheet.dart';

class PostSettingsBottomSheet extends StatefulWidget {
  const PostSettingsBottomSheet({
    required this.schedulePostCallback,
    required this.selectedDate,
    required this.selectedTime,
    super.key,
  });

  final Function schedulePostCallback;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  @override
  State<PostSettingsBottomSheet> createState() =>
      _PostSettingsBottomSheetState();
}

class _PostSettingsBottomSheetState extends State<PostSettingsBottomSheet> {
  Map<String, dynamic>? selectedDateTime;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    selectedDate = widget.selectedDate;
    selectedTime = widget.selectedTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHandler.screenWidth * 0.02,
            vertical: ScreenSizeHandler.screenHeight * 0.02),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Post Settings',
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.bigger * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      radius: ScreenSizeHandler.bigger * 0.018,
                      child: Icon(
                        Icons.clear,
                        size: ScreenSizeHandler.bigger * 0.026,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () async {
                selectedDateTime = await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const SchedulePostBottomSheet();
                  },
                );
                if (selectedDateTime != null) {
                  widget.schedulePostCallback(
                      true,
                      selectedDateTime!['selectedDate'],
                      selectedDateTime!['selectedTime']);
                  setState(() {
                    selectedDate = selectedDateTime!['selectedDate'];
                    selectedTime = selectedDateTime!['selectedTime'];
                  });
                }
              },
              leading: Icon(selectedDateTime == null
                  ? Icons.calendar_today_outlined
                  : Icons.calendar_month_rounded),
              title: const Text("Schedule Post"),
              trailing: selectedDate == null
                  ? const Icon(Icons.keyboard_arrow_right)
                  : Text(
                      "${formatDate(selectedDate!)}, ${formatTime(selectedTime!)}",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: ScreenSizeHandler.bigger * 0.0185),
                    ),
            )
          ],
        ),
      ),
    );
  }
}