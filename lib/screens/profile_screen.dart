import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/edit_profile_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  static const String id = 'profile_screen';
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAppBarExpanded = true;
  bool isMyProfile = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 120.0,
              maxHeight: 400.0,
              onExpandStatusChange: (expanded) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if (isAppBarExpanded != expanded) {
                    setState(() {
                      isAppBarExpanded = expanded;
                    });
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Positioned(
                      left: 0.0,
                      top: 15.0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: ScreenSizeHandler.screenWidth * 0.75,
                      top: 15.0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(FontAwesomeIcons.share, color: Colors.white, size:20),
                          ),
                        ],
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _tabController.animation!,
                      builder: (context, child) {
                        return Padding(
                          padding: EdgeInsets.only(left: isAppBarExpanded?20.0:40.0, bottom: 40.0),
                          child: Row(
                            children: [
                              Image.asset('assets/images/elham_final_logo.png',
                                  width: isAppBarExpanded ? 70 : 25,
                                  height: isAppBarExpanded ? 70 : 25),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'david',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isAppBarExpanded ? 30.0 : 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isAppBarExpanded) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 60.0, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, EditProfileScreen.id);
                                  },
                                  child: Text(isMyProfile?'Edit':'Follow',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold ),),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                  ),
                                ),
                                if (!isMyProfile) ...[

                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.message_outlined, color: Colors.white, size:20),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.person_add_alt_outlined, color: Colors.white,size:25),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shape: CircleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0),
                                    ),
                                  ),
                                ),
                                ]

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text('u/david . 1 karma . Mar 24,2023\n0 Gold',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13)),
                          ),
                          isMyProfile?
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add, color: Colors.white),
                                  Text('Add social link',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                            ),
                          ):SizedBox(height: 30,),
                        ],
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.blue,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white.withOpacity(0.5),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: <Widget>[
                            Tab(text: 'Posts'),
                            Tab(text: 'Comments'),
                            Tab(text: 'About'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Center(child: Text('Tab 1 Content')),
                Center(child: Text('Tab 2 Content')),
                Center(child: Text('Tab 3 Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.onExpandStatusChange,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final ValueChanged<bool> onExpandStatusChange;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isAppBarExpanded = shrinkOffset < 200;
    onExpandStatusChange(isAppBarExpanded);
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
