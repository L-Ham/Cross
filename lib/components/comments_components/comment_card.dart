import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/comments_components/line_painter.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class Comment {
  String username;
  final String content;
  int upvotes;
  bool isUpvoted = false;
  bool isDownvoted = false;
  bool collapsed = false;
  bool isUsernameBlocked = false;
  bool isUsernameTileClicked = false;
  final List<Comment> replies; // List of replies

  Comment({
    required this.username,
    required this.content,
    required this.upvotes,
    this.replies = const [], // Initialize replies as an empty list
  });
}

class CommentCard extends StatefulWidget {
  final Comment comment;

  const CommentCard({
    required this.comment,
    Key? key,
  }) : super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: () {
            setState(() {
              widget.comment.collapsed = !widget.comment.collapsed;
              widget.comment.isUsernameTileClicked =
                  !widget.comment.isUsernameTileClicked;
            });
          },
          leading: GestureDetector(
            onTap: () {
              // TODO: Navigate to user profile
            },
            child: CircleAvatar(
              backgroundImage: AssetImage(
                widget.comment.isUsernameBlocked &&
                        !widget.comment.isUsernameTileClicked
                    ? 'assets/images/blocked_account_avatar.png'
                    : 'assets/images/redditAvata2.png',
              ),
              radius: 15,
            ),
          ),
          title: GestureDetector(
            onTap: () {
              //TODO: Navigate to user profile
            },
            child: Row(
              children: [
                Text(
                  widget.comment.isUsernameBlocked &&
                          !widget.comment.isUsernameTileClicked
                      ? 'Blocked Author'
                      : "${widget.comment.username}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!widget.comment.collapsed) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.comment.content,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          color: kBackgroundColor,
                          height: 450,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.ios_share_outlined),
                                  title: const Text('Share'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(
                                      Icons.bookmark_border_outlined),
                                  title: const Text('Save'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(
                                      Icons.notifications_none_rounded),
                                  title: const Text('Get reply notifications'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.arrow_upward_outlined),
                                  title: const Text('Give Gold'),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: const Icon(Icons.copy_rounded),
                                  title: const Text('Copy text'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    Clipboard.setData(ClipboardData(
                                        text: widget.comment.content));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/copy_text_black.png'),
                                              height: 25,
                                              width: 25,
                                            ),
                                            Text(
                                                'Your copy is ready for pasta!'),
                                          ],
                                        ),
                                        backgroundColor: Colors.white,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.only(
                                          left: ScreenSizeHandler.screenWidth *
                                              kButtonWidthRatio,
                                          right: ScreenSizeHandler.screenWidth *
                                              kButtonWidthRatio,
                                          bottom:
                                              ScreenSizeHandler.screenHeight *
                                                  0.025,
                                        ),
                                        duration: const Duration(seconds: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.compare_arrows_sharp),
                                  title: const Text('Collapse thread'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      widget.comment.collapsed = true;
                                      widget.comment.isUsernameTileClicked =
                                          false;
                                    });
                                  },
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.no_accounts_outlined),
                                  title: widget.comment.isUsernameBlocked
                                      ? const Text('Unblock account')
                                      : const Text('Block account'),
                                  onTap: () async {
                                    widget.comment.isUsernameBlocked == false
                                        ? {
                                            Navigator.pop(context),
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                    ),
                                                    backgroundColor:
                                                        kBackgroundColor,
                                                    elevation: 0.0,
                                                    title: const Text(
                                                        'Are you sure?',
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                    content: const Text(
                                                        'You won\'t see posts or comments from this user.'),
                                                    actions: [
                                                      Container(
                                                        width: ScreenSizeHandler
                                                                .screenWidth *
                                                            0.3,
                                                        height: 40,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor: Colors
                                                                    .grey[
                                                                900], // background color
                                                          ),
                                                          child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey)),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: ScreenSizeHandler
                                                                .screenWidth *
                                                            0.3,
                                                        height: 40,
                                                        child: ElevatedButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                            ApiService
                                                                apiService =
                                                                ApiService(
                                                                    TokenDecoder
                                                                        .token);
                                                            await apiService
                                                                .blockUser(widget
                                                                    .comment
                                                                    .username);
                                                            scaffoldMessenger
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    '${widget.comment.username} was blocked'),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: ScreenSizeHandler
                                                                          .screenWidth *
                                                                      kButtonWidthRatio,
                                                                  right: ScreenSizeHandler
                                                                          .screenWidth *
                                                                      kButtonWidthRatio,
                                                                  bottom: ScreenSizeHandler
                                                                          .screenHeight *
                                                                      0.025,
                                                                ),
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0),
                                                                ),
                                                              ),
                                                            );

                                                            setState(() {
                                                              widget.comment
                                                                      .collapsed =
                                                                  true;
                                                              widget.comment
                                                                      .isUsernameBlocked =
                                                                  true;
                                                              widget.comment
                                                                      .isUsernameTileClicked =
                                                                  false;
                                                            });
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors
                                                                    .blue[300],
                                                          ),
                                                          child: const Text(
                                                            'Block',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                          }
                                        : {
                                            await ApiService(TokenDecoder.token)
                                                .unblockUser(
                                                    widget.comment.username),
                                            widget.comment.isUsernameBlocked =
                                                false,
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${widget.comment.username} unblocked'),
                                                backgroundColor: Colors.white,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                  left: ScreenSizeHandler
                                                          .screenWidth *
                                                      kButtonWidthRatio,
                                                  right: ScreenSizeHandler
                                                          .screenWidth *
                                                      kButtonWidthRatio,
                                                  bottom: ScreenSizeHandler
                                                          .screenHeight *
                                                      0.025,
                                                ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                            ),
                                            Navigator.pop(context),
                                            setState(() {
                                              widget.comment.collapsed = false;
                                            }),
                                          };
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.flag_outlined),
                                  title: const Text('Report'),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.reply_rounded,
                  color: widget.comment.isUpvoted ? Colors.green : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.comment.isUpvoted) {
                      widget.comment.upvotes--;
                      widget.comment.isUpvoted = false;
                    } else {
                      widget.comment.upvotes++;
                      widget.comment.isUpvoted = true;
                      widget.comment.isDownvoted = false;
                    }
                  });
                },
                icon: Icon(
                  Icons.arrow_upward,
                  color: widget.comment.isUpvoted ? Colors.green : Colors.white,
                ),
              ),
              Text(
                widget.comment.upvotes.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.comment.isDownvoted) {
                      widget.comment.upvotes++;
                      widget.comment.isDownvoted = false;
                    } else {
                      widget.comment.upvotes--;
                      widget.comment.isDownvoted = true;
                      widget.comment.isUpvoted = false;
                    }
                  });
                },
                icon: Icon(
                  Icons.arrow_downward,
                  color: widget.comment.isDownvoted ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          // Display replies
          Column(
            children: widget.comment.replies.map((reply) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: CustomPaint(
                    painter: LinePainter(), child: CommentCard(comment: reply)),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}