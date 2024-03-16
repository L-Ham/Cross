import 'package:flutter/material.dart';
import './components/community_name_text_box.dart';
import './components/custom_switch.dart';
import './components/community_type_selector.dart';
import 'constants.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String communityType = 'Public';
  String communityTypeDescription =
      'Anyone can view, post and comment to this community';
  bool isSwitched = false;
  bool activated = false;
  String errorText = '';

  String validateInput(String value) {
    if (value != null  && value.contains(new RegExp(r'[^\w\s]'))) {
      return 'Community names must be between $kCommunityNameMinLength-$kCommunityNameMaxLength characters, and can only contain letters, numbers, and underscores';
    }
    return '';
  }

  void createCommunity() {
    print('Community created');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Create a community',
              style: kPageTitleStyle.copyWith(
              fontSize: MediaQuery.of(context).size.height * kPageTitleFontSizeHeightRatio,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(9.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Text('Community name',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * kPageSubtitleFontSizeHeightRatio,
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            CommunityNameTextBox(
              controller: _controller,
              onChanged: (value) {
                if (value.length > kCommunityNameMaxLength) {
                  setState(() {
                    _controller.text = value.substring(0, kCommunityNameMaxLength);
                    _controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: _controller.text.length));
                  });
                }
                setState(() {
                  errorText = validateInput(value);
                  if (value.length >= kCommunityNameMinLength && errorText == '') {
                    activated = true;
                  } else {
                    activated = false;
                  }
                });
              },
              onClear: () {
                setState(() {
                  _controller.clear();
                });
              },
            ),
            Text(
              errorText,
              style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.height * kErrorTextHeightRatio,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Text('Community type',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * kPageSubtitleFontSizeHeightRatio,
                  )),
            ),
            CommunityTypeSelector(
              communityType: communityType,
              onCommunityTypeChanged: (type, description) {
                setState(() {
                  communityType = type;
                  communityTypeDescription = description;
                });
              },
            ),
            Text(communityTypeDescription,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * kCommunityTypeDescriptionHeightRatio,
                  color: Colors.grey,
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '18+ community',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * kPageTitleFontSizeHeightRatio,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomSwitch(
                  isSwitched: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                ElevatedButton(
                  onPressed: (activated) ? createCommunity : null,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.height*0.02, MediaQuery.of(context).size.height*kCreateCommunityButtonHeightRatio)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) => (activated) ? Colors.blueAccent : Colors.grey,
                    ),
                  ),
                  child: Text(
                    'Create community',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * kCreateCommunityButtonTextHeightRatio,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
