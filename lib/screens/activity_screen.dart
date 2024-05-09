import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/empty_dog.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/go_to_profile.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  static const id = "activity_screen";

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class ActivityTileClass {
  String title;
  String body;
  String notificationId;
  String? senderName;
  String? senderAvatar;
  String? subredditName;
  String? subredditAvatar;
  String type;
  bool isRead;
  String updatedAt;
  DateTime actualUpdatedAt;
  bool isVisible;

  ActivityTileClass({
    required this.title,
    required this.body,
    required this.notificationId,
    required this.senderName,
    required this.senderAvatar,
    required this.subredditName,
    required this.subredditAvatar,
    required this.type,
    required this.isRead,
    required this.updatedAt,
    required this.actualUpdatedAt,
    this.isVisible = true,
  });
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<ActivityTileClass> activities = [];
  List<ActivityTileClass> activitiesToday = [];
  List<ActivityTileClass> activitiesEarlier = [];
  ApiService apiService = ApiService(TokenDecoder.token);
  bool isLoading = false;

  void getAllActivities() async {
    setState(() {
      isLoading = true;
    });
    var response = await apiService.getAllActivity();

    List<dynamic> temp = response.map((item) {
      return ActivityTileClass(
        title: item['sent']['title'],
        body: item['sent']['body'],
        notificationId: item['_id'],
        senderName: item['senderName'],
        senderAvatar: item['senderAvatar'] ?? 'assets/images/avatarDaniel.png',
        subredditName: item['subredditName'] ?? '',
        subredditAvatar: item['subredditAvatar'] ?? 'assets/images/planet3.png',
        type: item['type'],
        isRead: item['isRead'],
        updatedAt: timeAgo((item['createdAt'])),
        actualUpdatedAt: DateTime.parse(item['createdAt']),
      );
    }).toList();
    if (mounted) {
      setState(() {
        activities = temp.cast<ActivityTileClass>();
      });
    }

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    activitiesToday = activities.where((activity) {
      return activity.actualUpdatedAt.isAfter(today);
    }).toList();
    
    activitiesEarlier = activities.where((activity) {
      return activity.actualUpdatedAt.isBefore(today);
    }).toList();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    getAllActivities();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Align(
            alignment: Alignment.topCenter,
            child: RedditLoadingIndicator(),
          )
        : Scaffold(
            body: (activitiesEarlier.isEmpty && activitiesToday.isEmpty)
                ? const Align(alignment: Alignment.center, child: EmptyDog())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (activitiesToday.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.05,
                                vertical:
                                    ScreenSizeHandler.screenHeight * 0.01),
                            child: Text("Last Hour",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        ScreenSizeHandler.bigger * 0.024)),
                          ),
                        if (activitiesToday.isNotEmpty)
                          Column(
                            children: [
                              for (var activity in activitiesToday)
                                AcitivityViewTile(activityTileClass: activity),
                            ],
                          ),
                        if (activitiesEarlier.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.05,
                                vertical:
                                    ScreenSizeHandler.screenHeight * 0.01),
                            child: Text("Earlier",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        ScreenSizeHandler.bigger * 0.024)),
                          ),
                        if (activitiesEarlier.isNotEmpty)
                          Column(
                            children: [
                              for (var activity in activitiesEarlier)
                                AcitivityViewTile(activityTileClass: activity),
                            ],
                          ),
                      ],
                    ),
                  ),
          );
  }
}

class AcitivityViewTile extends StatefulWidget {
  const AcitivityViewTile({
    required this.activityTileClass,
    super.key,
  });

  final ActivityTileClass activityTileClass;

  @override
  State<AcitivityViewTile> createState() => _AcitivityViewTileState();
}

class _AcitivityViewTileState extends State<AcitivityViewTile> {
  void showSnackBar(String snackBarText) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(snackBarText)),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.05,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.activityTileClass.isVisible
        ? GestureDetector(
            onTap: () {
              goToProfile(context, widget.activityTileClass.senderName!);
              setState(() {
                widget.activityTileClass.isRead = true;
              });
              ApiService apiService = ApiService(TokenDecoder.token);
              apiService.markNotificationAsRead(
                  widget.activityTileClass.notificationId);
            },
            child: Container(
              color: !widget.activityTileClass.isRead
                  ? Colors.blue.withOpacity(0.16)
                  : kBackgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenHeight * 0.019,
                    vertical: ScreenSizeHandler.screenHeight * 0.009),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.005),
                        child: Avatar(
                          avatar: widget.activityTileClass.senderAvatar!,
                          radius: ScreenSizeHandler.bigger * 0.017,
                          defaultImg: "assets/images/avatarDaniel.png",
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSizeHandler.screenWidth * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: ScreenSizeHandler.screenWidth * 0.6,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.activityTileClass.title,
                                    style: TextStyle(
                                      fontSize:
                                          ScreenSizeHandler.bigger * 0.018,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' • ${widget.activityTileClass.updatedAt}',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          ScreenSizeHandler.bigger * 0.016,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            widget.activityTileClass.body,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenSizeHandler.bigger * 0.016),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        int? choice = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const MoreActivityBottomSheet();
                          },
                        );
                        if (choice != null) {
                          if (choice == 1) {
                            apiService.hideNotification(
                                widget.activityTileClass.notificationId);
                            setState(() {
                              widget.activityTileClass.isVisible = false;
                              showSnackBar("Notification Hidden Successfully");
                            });
                          } else if (choice == 3) {
                            Map<String, dynamic> notificationSettings =
                                await apiService.getNotificationSettings();
                            notificationSettings =
                                notificationSettings['notificationSettings'];
                            switch (widget.activityTileClass.type) {
                              case "upvotedPost":
                                notificationSettings['upvotesToPosts'] = false;
                                break;
                              case "downvotedPost":
                                notificationSettings['upvotesToPosts'] = false;
                                break;
                              case "followed":
                                notificationSettings['newFollowers'] = false;
                                break;
                              case "commentedPost":
                                notificationSettings['comments'] = false;
                                break;
                              case "commentReply":
                                notificationSettings['repliesToComments'] =
                                    false;
                                break;
                              case "postedInSubreddit":
                                break;
                              default:
                                break;
                            }
                            var response =
                                await apiService.changeNotificationSettings(
                                    notificationSettings);
                            setState(() {
                              showSnackBar(response['message']);
                            });
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.006),
                        child: Icon(
                          Icons.more_horiz,
                          size: ScreenSizeHandler.bigger * 0.025,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}

class MoreActivityBottomSheet extends StatelessWidget {
  const MoreActivityBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenSizeHandler.screenHeight * 0.004),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, 1);
                },
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.remove_red_eye_outlined,
                    ),
                    titleText: "Hide this notification"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.cancel_outlined,
                    ),
                    titleText: "Disable updates from this community"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, 3);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.notifications_off_outlined,
                    ),
                    titleText: "Turn off this type of notification"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.04,
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
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
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
