import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class AddPostSearchBar extends StatelessWidget {
  const AddPostSearchBar({
    super.key,
    required this.isSearchFocused,
    required this.searchController,
  });

  final FocusNode isSearchFocused;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHandler.bigger * 0.055,
      child: TextField(
        controller: searchController,
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenSizeHandler.bigger * 0.018,
        ),
        focusNode: isSearchFocused,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: ScreenSizeHandler.bigger * 0.01),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[800],
          filled: true,
          hintText: 'Search for a community',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: ScreenSizeHandler.bigger * 0.018,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: ScreenSizeHandler.bigger * 0.03,
          ),
        ),
      ),
    );
  }
}
