import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isAppBarExpanded = true;
  int index = 0;
  var appBarColor = Color.fromARGB(136, 46, 80, 192);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Visibility(
          visible: !isAppBarExpanded,
          child: Text(
            'u/dave',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: ScreenSizeHandler.smaller * 0.042,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigator.pushNamed(context, EditProfileScreen.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Navigator.pushNamed(context, EditProfileScreen.id);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(136, 46, 80, 192), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/avatarDaniel.png',
                  height: ScreenSizeHandler.bigger * 0.1,
                  width: ScreenSizeHandler.bigger * 0.16,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.02,
                    horizontal: ScreenSizeHandler.screenWidth * 0.06,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.white),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.015,
                        horizontal: ScreenSizeHandler.screenWidth * 0.015,
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Edit'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.06,
                  ),
                  child: Text(
                    'Dave',
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.smaller * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.06,
                  ),
                  child: Text(
                    'u/dave . 1 karma . Apr 11,2024\n0 Gold',
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.smaller * 0.032,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenSizeHandler.screenHeight * 0.02,
                    left: ScreenSizeHandler.screenWidth * 0.05,
                    right: ScreenSizeHandler.screenWidth * 0.57,
                    bottom: ScreenSizeHandler.screenHeight * 0.02,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      backgroundColor: kBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.005,
                        horizontal: ScreenSizeHandler.screenWidth * 0.03,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Add social link',
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller *
                                kAcknowledgeTextSmallerFontRatio,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileTab(
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      text: 'Posts',
                    ),
                    ProfileTab(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      text: 'Comments',
                    ),
                    ProfileTab(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      text: 'About',
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSizeHandler.screenHeight * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenSizeHandler.screenWidth * 0.06),
                          child: Divider(
                            color:
                                index == 0 ? Colors.blue : Colors.transparent,
                            thickness: 3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenSizeHandler.screenWidth * 0.05),
                          child: Divider(
                            color:
                                index == 1 ? Colors.blue : Colors.transparent,
                            thickness: 3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenSizeHandler.screenWidth * 0.06),
                          child: Divider(
                            color:
                                index == 2 ? Colors.blue : Colors.transparent,
                            thickness: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              //physics: NeverScrollableScrollPhysics(),
              children: [
                ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Post $index'),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Comment $index'),
                    );
                  },
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ProfileTab({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: ScreenSizeHandler.screenWidth * 0.3,
        child: Padding(
          padding: EdgeInsets.only(
            top: ScreenSizeHandler.screenHeight * 0.015,
            bottom: ScreenSizeHandler.screenHeight * 0.005,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ScreenSizeHandler.smaller * 0.04,
            ),
          ),
        ),
      ),
    );
  }
}
