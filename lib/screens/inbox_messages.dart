import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/messages_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class InboxMessagesScreen extends StatefulWidget {
  const InboxMessagesScreen({Key? key}) : super(key: key);
  static const id = 'inbox_messages_screen';

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
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _tabController,
          indicatorColor: Color.fromARGB(255, 70, 111, 205),
          labelColor: Colors.white,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                  width: ScreenSizeHandler.screenWidth*0.01, color: Color.fromARGB(255, 70, 111, 205)),
              insets: EdgeInsets.symmetric(horizontal: 80.0)),
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(text: 'Activity'),
            Tab(text: 'Messages'),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('Activity Screen')),
          MessagesScreen(),
        ],
      ),
    );
  }
}
