import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/notifications_settings_screen.dart';
import '../../utilities/screen_size_handler.dart';
import '../settings_components/settings_tile.dart';
import '../settings_components/settings_tile_leading_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class SubredditFeedSortTypeBottomSheet extends StatelessWidget {
  late String sortType = 'Hot';

  SubredditFeedSortTypeBottomSheet({this.sortType = "Hot"});

  ApiService apiService = ApiService(TokenDecoder.token);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeHandler.screenWidth * 0.96,
      height: ScreenSizeHandler.screenHeight * 0.36,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScreenSizeHandler.screenWidth * 0.04,
                top: ScreenSizeHandler.screenHeight * 0.015,
                bottom: ScreenSizeHandler.screenHeight * 0.004),
            child: Text("SORT POSTS BY",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: kDisabledButtonColor,
                    fontSize: ScreenSizeHandler.bigger * 0.016,
                    fontWeight: FontWeight.w500)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ScreenSizeHandler.screenWidth * 0.9,
                child: Center(
                  child: Divider(
                    color: Color.fromARGB(255, 72, 71, 71),
                    thickness: 1.0,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              sortType = "Hot";
              Navigator.pop(context, sortType);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenSizeHandler.screenWidth * 0.04,
                  bottom: ScreenSizeHandler.screenHeight * 0.008,
                  top: ScreenSizeHandler.screenHeight * 0.004),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.fire,
                      color: sortType == "Hot"
                          ? Colors.white
                          : kDisabledButtonColor,
                      size: ScreenSizeHandler.bigger * 0.025),
                  SizedBox(
                    width: ScreenSizeHandler.screenWidth * 0.045,
                  ),
                  Text(
                    "Hot",
                    style: TextStyle(
                      color: sortType == "Hot"
                          ? Colors.white
                          : kDisabledButtonColor,
                      fontSize: ScreenSizeHandler.bigger * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.screenHeight * 0.008),
            child: GestureDetector(
                onTap: () {
                  sortType = "New";
                  Navigator.pop(context, sortType);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizeHandler.screenWidth * 0.04,
                      vertical: ScreenSizeHandler.screenHeight * 0.008),
                  child: Row(
                    children: [
                      Icon(Icons.settings_outlined,
                          color: sortType == "New"
                              ? Colors.white
                              : kDisabledButtonColor,
                          size: ScreenSizeHandler.bigger * 0.025),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.045,
                      ),
                      Text(
                        "New",
                        style: TextStyle(
                          color: sortType == "New"
                              ? Colors.white
                              : kDisabledButtonColor,
                          fontSize: ScreenSizeHandler.bigger * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.screenHeight * 0.008),
            child: GestureDetector(
                onTap: () {
                  sortType = "Top";
                  Navigator.pop(context, sortType);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizeHandler.screenWidth * 0.04,
                      vertical: ScreenSizeHandler.screenHeight * 0.008),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowUpFromBracket,
                          color: sortType == "Top"
                              ? Colors.white
                              : kDisabledButtonColor,
                          size: ScreenSizeHandler.bigger * 0.025),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.045,
                      ),
                      Text(
                        "Top",
                        style: TextStyle(
                          color: sortType == "Top"
                              ? Colors.white
                              : kDisabledButtonColor,
                          fontSize: ScreenSizeHandler.bigger * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: ScreenSizeHandler.screenHeight * 0.008),
            child: GestureDetector(
                onTap: () {
                  sortType = "Rising";
                  Navigator.pop(context, sortType);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.04,
                      top: ScreenSizeHandler.screenHeight * 0.008,
                      bottom: ScreenSizeHandler.screenHeight * 0.01),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.arrowTrendUp,
                          color: sortType == "Rising"
                              ? Colors.white
                              : kDisabledButtonColor,
                          size: ScreenSizeHandler.bigger * 0.025),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.045,
                      ),
                      Text(
                        "Rising",
                        style: TextStyle(
                          color: sortType == "Rising"
                              ? Colors.white
                              : kDisabledButtonColor,
                          fontSize: ScreenSizeHandler.bigger * 0.02,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.04,
                  vertical: ScreenSizeHandler.screenHeight * 0.008),
              child: Container(
                height: ScreenSizeHandler.screenHeight * 0.04,
                width: ScreenSizeHandler.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kFillingColor),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Close',
                    style: TextStyle(
                        color: Colors.grey,
                        decorationColor: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
