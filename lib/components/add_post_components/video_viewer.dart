import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utilities/screen_size_handler.dart';
import 'add_post_clear_button.dart';
import 'change_post_type_bottom_sheet.dart';

class VideoViewer extends StatelessWidget {
  const VideoViewer(
      {super.key, required this.removeVideo, required this.controller});

  final Function() removeVideo;
  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: ScreenSizeHandler.bigger * 0.19,
              height: ScreenSizeHandler.bigger * 0.2,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRect(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller.value.size.width,
                          height: controller.value.size.height,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -ScreenSizeHandler.bigger * 0.01,
                    top: -ScreenSizeHandler.bigger * 0.01,
                    child: AddPostClearButton(
                      buttonSizeRatio: 0.07,
                      onPressed: () async {
                        final choice = await showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const ChangePostTypeBottomSheet(
                              bodyText:
                                  "Your video will be removed from your post. You can add another.",
                              titleText: "Discard Video?",
                              rightButtonText: "Yes, Discard",
                            );
                          },
                        );
                        if (choice == "continue") {
                          removeVideo();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        : Container();
  }
}
