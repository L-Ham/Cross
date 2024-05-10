import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';

import 'package:clipboard/clipboard.dart';
import 'package:reddit_bel_ham/screens/new_message_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';
import 'package:reddit_bel_ham/components/subreddit_components/ellipsis_tile.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

ApiService apiService = ApiService(TokenDecoder.token);

Future<void> muteCommunity(String subredditName) async {
  await apiService.muteCommunity(subredditName);
}

Future<void> unmuteCommunity(String subredditName) async {
  await apiService.unmuteCommunity(subredditName);
}

Future<void> joinCommunity(String subredditID) async {
  await apiService.joinCommunity(subredditID);
}

Future<void> leaveCommunity(String subredditID) async {
  await apiService.leaveCommunity(subredditID);
}

Widget buildSubredditEllipsisModalBottomSheet(
    BuildContext context, Subreddit subreddit) {
  bool needRefresh = false;
  return SafeArea(
    child: Container(
      height: ScreenSizeHandler.screenHeight * 0.27,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
          vertical: ScreenSizeHandler.screenHeight * 0.015,
          horizontal: ScreenSizeHandler.screenWidth * 0.04),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "More actions...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenSizeHandler.bigger * 0.023,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: ScreenSizeHandler.screenHeight * 0.01,
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, NewMessageScreen.id, arguments: {
                    "isSubreddit": true,
                    "subredditName": subreddit.name,
                    "isReply": false
                  });
                },
                child: EllipsisTile(
                    tileText: "Message moderators",
                    tileIcon: FontAwesomeIcons.envelope),
              ),
              GestureDetector(
                onTap: () {
                  if (subreddit.isMuted) {
                    needRefresh = true;
                    unmuteCommunity(subreddit.name);
                    Navigator.pop(context, needRefresh);
                  } else {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) => SafeArea(
                        child: Container(
                          width: ScreenSizeHandler.screenWidth,
                          height: ScreenSizeHandler.screenHeight * 0.26,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 43, 41, 41),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                ScreenSizeHandler.bigger * 0.008),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Mute r/${subreddit.name}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            ScreenSizeHandler.bigger * 0.03,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                  "You won't see posts from r/${subreddit.name} in your feeds or recommendations anymore.",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 173, 164, 164),
                                      fontSize: ScreenSizeHandler.bigger * 0.02,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        needRefresh = false;
                                        Navigator.pop(context, needRefresh);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 173, 164, 164),
                                            fontSize:
                                                ScreenSizeHandler.bigger * 0.02,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        needRefresh = true;
                                        muteCommunity(subreddit.name);
                                        Navigator.pop(context, needRefresh);
                                        Navigator.pop(context, needRefresh);
                                      },
                                      style: ButtonStyle(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) {
                                          return BorderSide(
                                              color: kSubredditJoinedColor,
                                              width: ScreenSizeHandler
                                                      .screenWidth *
                                                  0.0034);
                                        }),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        minimumSize: MaterialStateProperty.all(
                                            Size.zero),
                                        fixedSize:
                                            MaterialStateProperty.all(Size(
                                          ScreenSizeHandler.screenWidth * 0.33,
                                          ScreenSizeHandler.screenHeight * 0.04,
                                        )),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            ScreenSizeHandler.bigger *
                                                0.0000001),
                                        child: Text(
                                          'Yes, Mute',
                                          style: TextStyle(
                                              color: kSubredditJoinedColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  ScreenSizeHandler.bigger *
                                                      0.019),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: EllipsisTile(
                    tileText: subreddit.isMuted
                        ? "Unmute r/${subreddit.name}"
                        : "Mute r/${subreddit.name}",
                    tileIcon: FontAwesomeIcons.volumeXmark),
              ),
              if (subreddit.isJoined)
                GestureDetector(
                  onTap: () async {
                    needRefresh = true;
                    await leaveCommunity(subreddit.id);
                    Navigator.pop(context, needRefresh);
                  },
                  child: EllipsisTile(
                      tileText: "Leave r/${subreddit.name}",
                      tileIcon: FontAwesomeIcons.circleMinus),
                )
              else
                GestureDetector(
                  onTap: () async {
                    needRefresh = true;
                    await joinCommunity(subreddit.id);
                    Navigator.pop(context, needRefresh);
                  },
                  child: EllipsisTile(
                      tileText: "Join", tileIcon: FontAwesomeIcons.circlePlus),
                ),
            ],
          ),
        ],
      ),
    ),
  );
}
