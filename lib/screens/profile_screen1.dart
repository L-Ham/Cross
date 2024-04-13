import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/text_link.dart';

class ProfileScreenApp extends StatelessWidget {
  static const String id = 'profile_screen';
  const ProfileScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Posts', 'Comments', 'About'];
    return DefaultTabController(
      length: tabs.length, // This is the number of tabs.
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                // This widget takes the overlapping behavior of the SliverAppBar,
                // and redirects it to the SliverOverlapInjector below. If it is
                // missing, then it is possible for the nested "inner" scroll view
                // below to end up under the SliverAppBar even when the inner
                // scroll view thinks it has not been scrolled.
                // This is not necessary if the "headerSliverBuilder" only builds
                // widgets that do not overlap the next sliver.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: Text(
              'u/dave',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: ScreenSizeHandler.smaller * 0.042,
                fontWeight: FontWeight.bold,
            ),
          ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                  flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade900,
                              Colors.black,
                            ],
                          ),
                        ),
                    child: FlexibleSpaceBar(

                      titlePadding: EdgeInsets.only(
                          left: ScreenSizeHandler.screenWidth * 0.11,
                          bottom: ScreenSizeHandler.screenHeight * 0.2
                      ),
                      title: Image.asset('assets/images/avatarDaniel.png',
                          width: ScreenSizeHandler.smaller * 0.05),
                      expandedTitleScale: 3,
                      background: Padding(
                        padding: EdgeInsets.only(
                          left: ScreenSizeHandler.screenWidth*0.11,
                          top: ScreenSizeHandler.screenHeight*0.33
                        ),
                        child: Column(
                          children: [
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
                                  side: BorderSide(color: Colors.white)),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    ScreenSizeHandler.screenHeight * 0.015,
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.015,
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Edit')),
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
                          right: ScreenSizeHandler.screenWidth *0.57,
                          bottom: 
                          ScreenSizeHandler.screenHeight * 0.02,
                        ),
                        child: ElevatedButton(
                          
                            style: ElevatedButton.styleFrom(
                              
                              foregroundColor: Colors.white70,
                              backgroundColor: kBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),

                              ),
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    ScreenSizeHandler.screenHeight * 0.005,
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.03,
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text('Add social link', style: TextStyle(fontSize: ScreenSizeHandler.smaller* kAcknowledgeTextSmallerFontRatio),),
                              ],
                            )),
                      ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  // title:
                  //     Image.asset('assets/images/avatarDaniel.png', height: 30),
                  pinned: true,
                  expandedHeight: ScreenSizeHandler.screenHeight * 0.4,
                  // The "forceElevated" property causes the SliverAppBar to show
                  // a shadow. The "innerBoxIsScrolled" parameter is true when the
                  // inner scroll view is scrolled beyond its "zero" point, i.e.
                  // when it appears to be scrolled below the SliverAppBar.
                  // Without this, there are cases where the shadow would appear
                  // or not appear inappropriately, because the SliverAppBar is
                  // not actually aware of the precise position of the inner
                  // scroll views.
                  // forceElevated: !innerBoxIsScrolled,

                  bottom: TabBar(
                    // These are the widgets to put in each tab in the tab bar.
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: tabs.map((String name) {
              return SafeArea(
                
                top: false,
                bottom: false,
                child: Builder(

                  // This Builder is needed to provide a BuildContext that is
                  // "inside" the NestedScrollView, so that
                  // sliverOverlapAbsorberHandleFor() can find the
                  // NestedScrollView.
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      
                      // The "controller" and "primary" members should be left
                      // unset, so that the NestedScrollView can control this
                      // inner scroll view.
                      // If the "controller" property is set, then this scroll
                      // view will not be associated with the NestedScrollView.
                      // The PageStorageKey should be unique to this ScrollView;
                      // it allows the list to remember its scroll position when
                      // the tab view is not on the screen.
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          // This is the flip side of the SliverOverlapAbsorber
                          // above.
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          // In this example, the inner scroll view has
                          // fixed-height list items, hence the use of
                          // SliverFixedExtentList. However, one could use any
                          // sliver widget here, e.g. SliverList or SliverGrid.
                          sliver: SliverFixedExtentList(
                            // The items in this example are fixed to 48 pixels
                            // high. This matches the Material Design spec for
                            // ListTile widgets.
                            itemExtent: 48.0,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                // This builder is called for each child.
                                // In this example, we just number each list item.
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              // The childCount of the SliverChildBuilderDelegate
                              // specifies how many children this inner list
                              // has. In this example, each tab has a list of
                              // exactly 30 items, but this is arbitrary.
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
