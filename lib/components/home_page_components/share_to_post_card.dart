

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/constants.dart';

class sharetoPostCard extends StatelessWidget {
  final Post post;
  sharetoPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return buildShareToPostCard(context, post);
  }
}

buildShareToPostCard(BuildContext context, Post post) {
  return Container(
    margin: EdgeInsets.only(top:10,bottom:10,),
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(15),
      border:Border.all(color:Color.fromARGB(255, 72, 71, 71)),
    ),
    height:100,
    width: MediaQuery.of(context).size.width * 0.9, 
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:7.0, right:5.0, top:5.0, bottom: 5.0),
          child: Text(
            post.username,
            style:TextStyle(color:const Color.fromARGB(255, 151, 150, 150),
            fontSize: 12)
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FittedBox(
                child: Text(
                  post.contentTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: constraints.maxWidth * 0.05, // 5% of parent width
                  ),
                ),
                fit: BoxFit.scaleDown, // scales down the text to fit within the box
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:7.0),
          child: Text(
            "${post.upvotes} upvotes . ${post.comments} comments",
            style: TextStyle(
              color: const Color.fromARGB(255, 151, 150, 150),
              fontSize: 12,
            ),
          ),
        )
      ],
    ),
  );
}