import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final dynamic conversation;

  ChatTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/5962/5962463.png",
        ),
      ),
      title: Text(conversation['chatName'] != null
          ? conversation['chatName']
          : 'chatName'),
      subtitle: Text(
          'Recently visited'), // Replace 'recentlyVisited' with the actual key
    );
  }
}
