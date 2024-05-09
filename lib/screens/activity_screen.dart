import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/empty_dog.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'dart:convert';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  static const id = "activity_screen";

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class ActivityTileClass {
  final String title;
  final String body;
  final String notificationId;
  final String? senderName;
  final String? senderAvatar;
  final String? subredditName;
  final String? subredditAvatar;
  final String type;
  final bool isRead;
  final String updatedAt;
  final DateTime actualUpdatedAt;

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
        updatedAt: timeAgo((item['updatedAt'])),
        actualUpdatedAt: DateTime.parse(item['updatedAt']),
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

    setState(() {
      isLoading = false;
    });
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
                            child: Text("Today",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        ScreenSizeHandler.bigger * 0.024)),
                          ),
                        if (activitiesToday.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: activitiesToday.length,
                            itemBuilder: (context, index) {
                              return AcitivityViewTile(
                                  activityTileClass: activitiesToday[index]);
                            },
                          ),
                        if (activitiesEarlier.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.05,
                                vertical:
                                    ScreenSizeHandler.screenHeight * 0.01),
                            child: Text("Today",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        ScreenSizeHandler.bigger * 0.024)),
                          ),
                        if (activitiesEarlier.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: activitiesToday.length,
                            itemBuilder: (context, index) {
                              return AcitivityViewTile(
                                  activityTileClass: activitiesEarlier[index]);
                            },
                          ),
                      ],
                    ),
                  ),
          );
  }
}

class AcitivityViewTile extends StatelessWidget {
  const AcitivityViewTile({
    required this.activityTileClass,
    super.key,
  });

  final ActivityTileClass activityTileClass;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        color: !activityTileClass.isRead
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
                    avatar: activityTileClass.senderAvatar!,
                    radius: ScreenSizeHandler.bigger * 0.017,
                    defaultImg: "assets/images/avatarDaniel.png",
                  )),
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
                              text: activityTileClass.title,
                              style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger * 0.018,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' • ${activityTileClass.updatedAt}',
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
                      activityTileClass.body,
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
      ),
    );
  }
}
