import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

import '../components/add_post_components/community_rule_tile.dart';

class CommunityRulesScreen extends StatefulWidget {
  const CommunityRulesScreen({super.key});

  static const String id = "community_rules_screen";

  @override
  State<CommunityRulesScreen> createState() => _CommunityRulesScreenState();
}

class _CommunityRulesScreenState extends State<CommunityRulesScreen> {
  List<String> rulesTitles = [];
  List<String> rulesBody = [];
  String subredditId = '';
  ApiService apiService = ApiService(TokenDecoder.token);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    subredditId = ModalRoute.of(context)!.settings.arguments as String;
    getSubredditRules();
    super.didChangeDependencies();
  }

  void getSubredditRules() async {
    Map<String, dynamic> responseBody =
        await apiService.getSubredditRules(subredditId);
    List<dynamic> rules = responseBody['rules'];
    List<String> titles = [];
    List<String> bodies = [];
    for (int i = 0; i < rules.length; i++) {
      titles.add(rules[i]['ruleText']);
      bodies.add(rules[i]['fullDescription']);
    }
    if (mounted) {
      setState(() {
        rulesTitles = titles;
        rulesBody = bodies;
      });
    }
  }

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
