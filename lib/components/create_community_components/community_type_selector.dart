import 'package:flutter/material.dart';
import 'community_type_tile.dart';
import '../../utilities/screen_size_handler.dart';
import '../../constants.dart';

class CommunityTypeSelector extends StatelessWidget {
  final String communityType;
  final Function(String, String) onCommunityTypeChanged;

  const CommunityTypeSelector({super.key, 
    required this.communityType,
    required this.onCommunityTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: ScreenSizeHandler.bigger * kCommunityTypeShowModalMaxHeightRatio),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CommunityTypeTile(
                          title: 'Public',
                          subtitle:
                              'Anyone can view, post and comment to this community',
                          icon: Icons.account_circle_outlined,
                          onTap: () {
                            onCommunityTypeChanged(
                              'Public',
                              'Anyone can view, post and comment to this community',
                            );
                            Navigator.pop(context);
                          },
                        ),
                        CommunityTypeTile(
                          title: 'Restricted',
                          subtitle:
                              'Anyone can view this community, but only approved users can post',
                          icon: Icons.check_circle_outline,
                          onTap: () {
                            onCommunityTypeChanged(
                              'Restricted',
                              'Anyone can view this community, but only approved users can post',
                            );
                            Navigator.pop(context);
                          },
                        ),
                        CommunityTypeTile(
                          title: 'Private',
                          subtitle:
                              'Only approved users can view and submit to this community',
                          icon: Icons.lock_outline,
                          onTap: () {
                            onCommunityTypeChanged(
                              'Private',
                              'Only approved users can view and submit to this community',
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Row(children: [
        Text(
          communityType,
          style: TextStyle(
            fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio *1.2,
            fontWeight: FontWeight.w500,
          ),
        ),
        Icon(
          Icons.arrow_drop_down,
          size: MediaQuery.of(context).size.height * kCommunityTypeArrowDownIconSize,
        )
      ]),
    );
  }
}
