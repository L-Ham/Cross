import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
// import 'package:url_launcher/url_launcher.dart';

class TrendingPost {
  final String? content;
  final String contentTitle;
  final AssetImage image;

  TrendingPost({
    required this.contentTitle,
    required this.image,
    this.content,
  });
}

class TrendingPostCard extends StatefulWidget {
  final TrendingPost post;
  const TrendingPostCard({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  _TrendingPostCardState createState() => _TrendingPostCardState();
}

class _TrendingPostCardState extends State<TrendingPostCard> {
  @override
  Widget build(BuildContext context) {
    return buildTrendingPostCard(widget.post, context);
  }

  // Future<void> _launchURL(String url) async {
  //   if (!await launchUrl(Uri.parse(url))) {
  //     throw 'Could not launch $url';
  //   }
  // }

  Widget buildTrendingPostCard(TrendingPost post, BuildContext context) {
    return Container(
      color: Colors.black,
      width: ScreenSizeHandler.smaller * 0.4,
      height: ScreenSizeHandler.bigger * 0.13,
      child: Padding(
        padding: EdgeInsets.all(ScreenSizeHandler.smaller * 0.013),
        child: GestureDetector(
          // onTap: onPressed,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              // Image.network(
              //   imageUrl,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: post.image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Text(
                    post.contentTitle,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: kDefaultFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
  }
}
