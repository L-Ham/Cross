import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedMenuItem = "Home";
  final List<String> menuItems = ['Home', 'Popular', 'Latest News'];
  final List<Post> posts = [
    Post(
      username: "r/DanielAdel",
      contentTitle: " Foodie Instagrammers, Let's Talk Strategy!",
      content:
          "  Hey fellow food lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Do you swear by natural lighting or do you have some secret editing tricks up your sleeve? And let's talk about captions too! I'm always struggling to strike the right balance between informative and witty. Let's share some wisdom and help each other elevate our Instagram game to the next level! 🍕✨",
      upvotes: 78,
      comments: 141,
    ),
    Post(
      username: "r/AnnieBakesCakes",
      contentTitle: " Curating Culinary Moments on Instagram: Tips & Tricks!",
      content:
          "Hey foodies! I've been pondering tellow fthe world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Dood lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. Ihe art of curating culinary moments on Instagram latelto learn from your experien",
      upvotes: 20,
      comments: 35,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 2.0),
          child: Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            Text(
              selectedMenuItem,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.search,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              radius: 25,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return buildPostCard(posts[index]);
        },
      ),
    );
  }

  Widget buildPostCard(Post post) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(radius: 15),
            title: Text(post.username, style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.contentTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  post.content,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: kFillingColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              post.isUpvoted ? post.upvotes-- : post.upvotes++;
                              post.isUpvoted = !post.isUpvoted;
                              post.isDownvoted = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0, right:8.0, top:3.0, bottom:4.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color:
                                      post.isUpvoted ? Colors.red : Colors.white,
                                      size: 18.0,
                                ),
                                Text(
                                  post.upvotes.toString(),
                                  style: TextStyle(color: Colors.white, 
                                  fontSize: 12.0),

                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              post.isDownvoted ? post.upvotes++ : post.upvotes--;
                              post.isDownvoted = !post.isDownvoted;
                              post.isUpvoted = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: post.isDownvoted
                                      ? const Color.fromARGB(255, 110, 85, 114)
                                      : Colors.white,
                                      size: 18.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle comment button tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: kFillingColor,
                                    ),
                                  ),
                                    child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.comment,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      post.comments.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                    ),
                                  )
                                ])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          padding: EdgeInsets.all(16.0),
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.35,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Share to...",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 100.0),
                              SizedBox(height: 16.0),
                              Text(
                                "Your username stays hidden when you share outside of Reddit",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: kHintTextColor,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.facebook, color: Colors.white),
                                  Icon(Icons.copy, color: Colors.white),
                                  Icon(Icons.email, color: Colors.white),
                                  Icon(Icons.more_horiz, color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: kFillingColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.share,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("147",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

