import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/video_player.dart';

import 'package:reddit_bel_ham/components/add_post_components/video_viewer.dart';

void main() {
  group('VideoViewer', () {
    late VideoPlayerController controller;

    setUp(() {
      controller = VideoPlayerController.network('https://example.com/video.mp4');
    });

    tearDown(() {
      controller.dispose();
    });
    testWidgets('should not display video player when controller is not initialized',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VideoViewer(
              removeVideo: () {},
              controller: VideoPlayerController.network(''),
            ),
          ),
        ),
      );

      expect(find.byType(VideoPlayer), findsNothing);
    });

  });
}