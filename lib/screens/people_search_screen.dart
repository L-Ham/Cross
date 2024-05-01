import 'package:flutter/material.dart';
import '../components/empty_dog.dart';
import '../components/searching_components/search_people_communities_tile.dart';

class PeopleSearchScreen extends StatefulWidget {
  const PeopleSearchScreen(
      {super.key,
      required this.userNames,
      required this.userAvatarImages});

  final List<String> userNames;
  final List<String> userAvatarImages;

  @override
  State<PeopleSearchScreen> createState() =>
      _PeopleSearchScreenState();
}

class _PeopleSearchScreenState extends State<PeopleSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return  widget.userNames.isEmpty
        ? const Center(
            child: EmptyDog(),
          )
        : SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < widget.userNames.length; i++)
            SearchCommunitiesPeopleTile(
              title: widget.userNames[i],
              description: '0 Karma',
              image: widget.userAvatarImages[i],
              isSubreddit: false,
            ),
        ],
      ),
    );
  }
}
