import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/empty_dog.dart';
import '../components/searching_components/search_people_communities_tile.dart';

class CommunitiesSearchScreen extends StatefulWidget {
  const CommunitiesSearchScreen(
      {super.key,
      required this.subredditNames,
      required this.subredditMembers,
      required this.subredditAvatarImages});

  final List<String> subredditNames;
  final List<int> subredditMembers;
  final List<String> subredditAvatarImages;
  @override
  State<CommunitiesSearchScreen> createState() =>
      _CommunitiesSearchScreenState();
}

class _CommunitiesSearchScreenState extends State<CommunitiesSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.subredditNames.isEmpty
        ? const Center(
            child: EmptyDog(),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < widget.subredditNames.length; i++)
                  SearchCommunitiesPeopleTile(
                    title: widget.subredditNames[i],
                    description: widget.subredditMembers[i].toString(),
                    image: widget.subredditAvatarImages[i],
                    isSubreddit: true,
                  ),
              ],
            ),
          );
  }
}
