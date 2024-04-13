import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/components/more_bottom_sheet_inbox.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class InboxMessagesScreen extends StatefulWidget {
  const InboxMessagesScreen({Key? key}) : super(key: key);
  static const id = 'home_page_screen';

  @override
  State<InboxMessagesScreen> createState() => _InboxMessagesScreenState();
}

class _InboxMessagesScreenState extends State<InboxMessagesScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: ScreenSizeHandler.screenWidth * 0.018,
                  right: ScreenSizeHandler.screenWidth * 0.02),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color.fromARGB(255, 70, 111, 205),
          labelColor: Colors.white,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  width: ScreenSizeHandler.screenWidth*0.01, color: Color.fromARGB(255, 70, 111, 205)),
              insets: EdgeInsets.symmetric(horizontal: 80.0)),
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(text: 'Activity'),
            Tab(text: 'Messages'),
          ],
        ),
        title: Center(
          child: Text(
            'Inbox',
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenSizeHandler.screenWidth * 0.04,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GestureDetector(
                onTap:() => {
                   showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          buildMoreModalBottomSheetinbox(context),
                    ),
                },
                child: Icon(
                  Icons.more_horiz_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              child: ProfileIconWithIndicator(isOnline: false),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Activity Screen')),
          Center(child: Text('Messages Screen')),
        ],
      ),
    );
  }
}
