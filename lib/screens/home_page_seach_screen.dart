import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> searchHistory = [
    'Flutter',
    'Dart',
    'Mobile Development',
  ];

  List<String> titles = [
    "Nardo Nayma!",
    "Habouba Nayma!",
    "David Nayem!",
    "Peter Nayem!",
    "DANIEL HAYMAWETNAAAAA33"
  ];
  List<String> descriptions = [
    "el7a2ooonaaaaaaa",
    "el7a2ooonaaaaaaa",
    "el7a2ooonaaaaaaa",
    "el7a2ooonaaaaaaa",
    "el7a2ooonaaaaaaa33333",
    "I WILL KILL YOU MWAHAHAHA!"
  ];

  List<String> images = [
    "assets/images/nardo_nayma.png",
    "assets/images/habouba_nayma.png",
    "assets/images/david_nayem.png",
    "assets/images/peter_nayem.png",
    "assets/images/daniel_haymawetna.png",
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: kHintTextColor),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:
                  EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.05),
              child: const Center(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
        backgroundColor: kBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.21,
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: GestureDetector(
                      child: Icon(
                        Icons.access_time,
                        size: ScreenSizeHandler.bigger * 0.03,
                      ),
                      onTap: () {
                        _searchController.text = searchHistory[index];
                      },
                    ),
                    title: Text(
                      searchHistory[index],
                      style:
                          TextStyle(fontSize: ScreenSizeHandler.bigger * 0.018),
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.cancel_outlined,
                        size: ScreenSizeHandler.bigger * 0.027,
                      ),
                      onTap: () {
                        setState(() {
                          searchHistory.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 10,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.06),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScreenSizeHandler.screenHeight * 0.01),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Trending Today",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  for (int i = 0; i < min(6, images.length); i++)
                    TrendingPreviewTile(
                        image: images[i],
                        title: titles[i],
                        description: descriptions[i])
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}

class TrendingPreviewTile extends StatelessWidget {
  const TrendingPreviewTile({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: ScreenSizeHandler.screenWidth * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Color.fromARGB(255, 140, 140, 244),
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenSizeHandler.bigger * 0.018),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey,
                        fontSize: ScreenSizeHandler.bigger * 0.015),
                    maxLines: 2,
                  )
                ],
              ),
            ),
            Image.asset(
              image,
              height: ScreenSizeHandler.bigger * 0.08,
              width: ScreenSizeHandler.bigger * 0.085,
            )
          ],
        ),
        Divider(
          color: Colors.grey[600]!,
          thickness: 0.5,
          height: ScreenSizeHandler.screenHeight * 0.05,
        )
      ],
    );
  }
}
