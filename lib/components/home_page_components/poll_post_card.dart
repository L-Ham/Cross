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
  List<int> votes = [15, 20, 30];
  bool isSubmitted = false;
  int sum = 0;
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
                    if (!isSubmitted) {
                      setState(() {
                        selectedOption = option;
                      });
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (isSubmitted) ...[
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    (votes[options.indexOf(option)] /
                                        sum.toDouble()),
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromARGB(255, 6, 52, 90)),
                                  minHeight: 30.0,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                        Row(
                          children: [
                            if (isSubmitted) ...[
                              SizedBox(width:ScreenSizeHandler.screenWidth * 0.07,),
                              Text(
                                votes[options.indexOf(option)].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      ScreenSizeHandler.screenWidth * 0.028,
                                ),
                              ),
                              SizedBox(
                                width: ScreenSizeHandler.screenWidth * 0.03,
                                height: ScreenSizeHandler.screenHeight * 0.05,
                              ),
                              Text(
                                option,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      ScreenSizeHandler.screenWidth * 0.028,
                                ),
                              ),
                              SizedBox(
                                width: ScreenSizeHandler.screenWidth * 0.02,
                              ),
                              if(selectedOption == option)
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: ScreenSizeHandler.screenWidth * 0.038,
                              )
                            ],
                            if (!isSubmitted) ...[
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
                                  fontSize:
                                      ScreenSizeHandler.screenWidth * 0.028,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            if (!isSubmitted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if(selectedOption == ''){
                        return;
                      }
                      isSubmitted = true;
                      votes[options.indexOf(selectedOption)]++;
                      sum = votes.reduce((value, element) => value + element);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          ScreenSizeHandler.smaller * 0.1),
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
