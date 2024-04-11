import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utilities/screen_size_handler.dart';
import 'add_post_clear_button.dart';
import 'image_deletion_bottom_sheet.dart';

class ImageEditViewer extends StatefulWidget {
  const ImageEditViewer(
      {super.key,
      required this.removeImage,
      required this.updateXFileList,
      required this.initialChoices});

  final Function() removeImage;
  final Function(List<XFile>) updateXFileList;
  final List<XFile> initialChoices;

  @override
  State<ImageEditViewer> createState() => _ImageEditViewerState();
}

class _ImageEditViewerState extends State<ImageEditViewer> {
  List<XFile> chosenImages = [];
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    chosenImages = widget.initialChoices;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            enableInfiniteScroll: false,
            aspectRatio: 1.0,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: chosenImages
              .map(
                (file) => Stack(
                  children: [
                    Center(
                      child: Image.file(File(file.path),
                          fit: BoxFit.cover, width: double.infinity),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
        Positioned(
          right: 0,
          child: AddPostClearButton(
            onPressed: () async {
              if (chosenImages.length == 1) {
                widget.removeImage();
              } else {
                final option = await showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return const ImageDeletionBottomSheet();
                  },
                );
                if (option == "current") {
                  setState(() {
                    chosenImages.removeAt(_currentIndex);
                  });
                } else if (option == "all") {
                  widget.removeImage();
                }
              }
            },
          ),
        ),
        Positioned(
          right: ScreenSizeHandler.screenWidth * 0.03,
          bottom: ScreenSizeHandler.screenHeight * 0.01,
          child: GestureDetector(
            onTap: () async {
              List<XFile>? moreImages = await _picker.pickMultiImage();
              setState(() {
                chosenImages.addAll(moreImages);
                widget.updateXFileList(chosenImages);
              });
            },
            child: Container(
              width: ScreenSizeHandler.bigger * 0.08,
              height: ScreenSizeHandler.bigger * 0.04,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.image,
                    color: Colors.white,
                    size: ScreenSizeHandler.smaller * 0.05,
                  ),
                  Text(
                    "Add",
                    style:
                        TextStyle(fontSize: ScreenSizeHandler.bigger * 0.015),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (chosenImages.length > 1)
          Positioned(
            bottom: ScreenSizeHandler.screenHeight * 0.01,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    child: DotsIndicator(
                      position: _currentIndex,
                      dotsCount: chosenImages.length,
                      mainAxisSize: MainAxisSize.min,
                      decorator: DotsDecorator(
                        size: Size.square(ScreenSizeHandler.bigger *
                            0.007), // Size of each dot
                        activeSize: Size(
                            ScreenSizeHandler.bigger * 0.007,
                            ScreenSizeHandler.bigger *
                                0.007), // Size of active dot
                        color: Colors.grey,
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
