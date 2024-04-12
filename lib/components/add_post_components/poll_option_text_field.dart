import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class PollOptionTextField extends StatelessWidget {
  const PollOptionTextField(
      {super.key,
      required this.i,
      required this.onTap,
      required this.controller,
      required this.onChanged});

  final int i;
  final Function() onTap;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: ScreenSizeHandler.bigger * 0.048,
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSizeHandler.screenHeight * 0.018),
              decoration: InputDecoration(
                hintText: "Option $i",
                fillColor: Colors.black,
                filled: true,
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenSizeHandler.screenHeight * 0.018),
                contentPadding:
                    EdgeInsets.only(bottom: ScreenSizeHandler.bigger * 0.02),
              ),
            ),
          ),
        ),
        if (i > 2)
          Padding(
            padding: EdgeInsets.only(
                right: ScreenSizeHandler.screenWidth * 0.02,
                left: ScreenSizeHandler.screenWidth * 0.04),
            child: GestureDetector(
                onTap: onTap,
                child: Icon(Icons.clear_sharp,
                    color: Colors.grey, size: ScreenSizeHandler.bigger * 0.04)),
          )
      ],
    );
  }
}