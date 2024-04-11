import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../components/add_post_components/community_rule_tile.dart';

class CommunityRulesScreen extends StatefulWidget {
  const CommunityRulesScreen({super.key});

  static const String id = "community_rules_screen";

  @override
  State<CommunityRulesScreen> createState() => _CommunityRulesScreenState();
}

class _CommunityRulesScreenState extends State<CommunityRulesScreen> {
  List<String> rulesTitles = [
    "Only Rocket League Related content",
    "No spamming",
    "No hate speech",
    "No NSFW content",
    "No personal information",
    "No self-promotion",
    "No low-effort posts",
  ];
  List<String> rulesBody = [
    "This community is dedicated to Rocket League. Please keep all posts and comments related to Rocket League.",
    "Spamming is not allowed in this community. Spamming includes posting the same content multiple times, posting irrelevant content, or posting content that is not related to Rocket League.",
    "Hate speech is not allowed in this community. Hate speech includes any content that is meant to harm or discriminate against others based on their.",
    "NSFW content is not allowed in this community. NSFW content includes any content that is meant to be sexual or explicit in nature.",
    "Personal information is not allowed in this community. Personal information includes any content that is meant to identify or reveal personal information about others.",
    "Self-promotion is not allowed in this community. Self-promotion includes any content that is meant to promote yourself or your own content.",
    "Low-effort posts are not allowed in this community. Low-effort posts include any content that is meant to be low-quality or low-effort in nature.",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Community Rules',
          style: TextStyle(
              fontSize:
                  ScreenSizeHandler.smaller * kAppBarTitleSmallerFontRatio,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.clear_sharp,
            size: ScreenSizeHandler.screenHeight * kCancelAppbarIconSizeRatio,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHandler.screenWidth * 0.055),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ScreenSizeHandler.screenHeight * 0.02),
                      child: Text(
                        "Rules are different for each community. Reviewing the rules can help you be more successfull when posting or commenting in this community.",
                        style: TextStyle(
                          fontSize: ScreenSizeHandler.bigger * 0.0175,
                          color: Colors.grey,
                          height: 1.2,
                        ),
                      ),
                    ),
                    for (int i = 0; i < rulesTitles.length; i++)
                      CommunityRuleTile(
                        ruleNum: i + 1,
                        ruleTitle: rulesTitles[i],
                        ruleDescription: rulesBody[i],
                      ),
                  ],
                ),
              ),
            ),
            RoundedButton(
              onTap: () {
                Navigator.pop(context);
              },
              buttonHeightRatio: 0.043,
              buttonWidthRatio: 0.5,
              buttonColor: kSwitchOnColor,
              child: const Text(
                "I Understand",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
