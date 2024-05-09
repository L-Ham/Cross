import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  static const id = "activity_screen";

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AcitivityViewTile(),
            AcitivityViewTile(),
          ],
        ),
      ),
    );
  }
}

class AcitivityViewTile extends StatelessWidget {
  const AcitivityViewTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.16),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHandler.screenHeight * 0.019,
            vertical: ScreenSizeHandler.screenHeight * 0.009),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.01),
              child: Avatar(
                avatar: "assets/images/avatarDaniel.png",
                radius: ScreenSizeHandler.bigger * 0.017,
                defaultImg: "assets/images/avatarDaniel.png",
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.015),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenSizeHandler.screenWidth * 0.6,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'u/FaridaSalem replied to your post in r/redditBelham',
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.018,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: ' • 1h',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenSizeHandler.bigger * 0.016,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Boooooo",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: ScreenSizeHandler.bigger * 0.016),
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.014),
              child: Icon(
                Icons.more_horiz,
                size: ScreenSizeHandler.bigger * 0.025,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
