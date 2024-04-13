import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class PollPost extends StatefulWidget {
  final Post post;

  const PollPost({required this.post});

  @override
  _PollPostState createState() => _PollPostState();
}

class _PollPostState extends State<PollPost> {
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color.fromARGB(255, 72, 71, 71)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.pollVotes.toString() + ' votes',
              style: TextStyle(
                fontSize: ScreenSizeHandler.screenWidth * 0.028,
              ),
            ),
            Divider(
              color: Color.fromARGB(255, 72, 71, 71),
              thickness: 1.0,
            ),
            Column(
              children: options.map((option) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOption = option;
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                        value: option,
                        groupValue: selectedOption,
                        activeColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value.toString();
                          });
                        },
                      ),
                      Text(
                        option,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeHandler.screenWidth * 0.028,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add your vote handling logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenSizeHandler.smaller * 0.1),
                  ),
                ),
                child: Text(
                  'Vote',
                  style: TextStyle(
                    fontSize: ScreenSizeHandler.screenWidth * 0.028,
                    color: Colors.black,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
