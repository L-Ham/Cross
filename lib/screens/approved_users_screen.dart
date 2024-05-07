import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_tile.dart';
import 'package:reddit_bel_ham/components/mod_tools_components/user_bottom_sheet_tile.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/screens/add_approved_user_screen.dart';


class ApprovedUsersScreen extends StatefulWidget {
  const ApprovedUsersScreen({super.key});

  static const String id = 'approved_users_screen';

  @override
  State<ApprovedUsersScreen> createState() => _ApprovedUsersScreenState();
}

class _ApprovedUsersScreenState extends State<ApprovedUsersScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  // String username = TokenDecoder.username;
  List<dynamic> approvedUsers = [];

  Future<void> getApprovedUsers () async {
    Map<String, dynamic> response = await apiService.getApprovedUsers("Dragon Oath");
    if (response['message'] == "Retrieved subreddit Approved Users Successfully") {
      setState(() {
        approvedUsers = response['approvedMembers'];
      });
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(response['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        }, 
      );
    }
   }

  @override
  void initState() {
    super.initState();
    //get the current user's community description
    getApprovedUsers();
  }

  void userOptions() async {
    String? newGender = await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            child: Container(
              color: Colors.grey[900],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserBottomSheetTile(
                      text: 'Send message',
                      icon: Icon(
                        FontAwesomeIcons.pen,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    UserBottomSheetTile(
                      text: 'View profile',
                      icon: Icon(
                        FontAwesomeIcons.circleUser,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    UserBottomSheetTile(
                      text: 'Remove',
                      icon: Icon(
                        FontAwesomeIcons.ban,
                        size: ScreenSizeHandler.bigger *
                            kSettingsLeadingIconRatio *
                            0.8,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    ContinueButton(
                      onPress: () {},
                      text: 'Cancel',
                      color: Colors.grey[800],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    setState(
      () {
        // if (newGender != null) {
        //   gender = newGender;
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Approved Users',
          style: TextStyle(
            fontSize: ScreenSizeHandler.bigger * 0.025,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: kBackgroundColor,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                iconSize: ScreenSizeHandler.smaller * 0.07,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddApprovedUserScreen.id);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                iconSize: ScreenSizeHandler.smaller * 0.07,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: approvedUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kSettingsHorizontalPaddingHeightRatio *
                          ScreenSizeHandler.screenWidth,
                    ),
                    child: Column(
                      children: [
                        UserTile(
                          titleText: approvedUsers[index]['userName'], //change this to 'u/$username',
                          subtitleText: '1 wk ago',
                          onTap: () {},
                          avatarLink: approvedUsers[index]['avatarImage'],
                          onIconTap: () {
                            userOptions();
                          },
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
