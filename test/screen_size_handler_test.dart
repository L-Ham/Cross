import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

void main() {
  group('ScreenSizeHandler', () {
    test('should initialize screen width and height correctly', () {
      ScreenSizeHandler.initialize(360, 640);

      expect(ScreenSizeHandler.screenWidth, 360);
      expect(ScreenSizeHandler.screenHeight, 640);
    });

    test('should set bigger and smaller dimensions correctly', () {
      ScreenSizeHandler.initialize(720, 1280);

      expect(ScreenSizeHandler.bigger, 1280);
      expect(ScreenSizeHandler.smaller, 720);

      ScreenSizeHandler.initialize(1280, 720);

      expect(ScreenSizeHandler.bigger, 1280);
      expect(ScreenSizeHandler.smaller, 720);
    });

    test('should update screen width and height correctly', () {
      ScreenSizeHandler.initialize(360, 640);

      expect(ScreenSizeHandler.screenWidth, 360);
      expect(ScreenSizeHandler.screenHeight, 640);

      ScreenSizeHandler.initialize(720, 1280);

      expect(ScreenSizeHandler.screenWidth, 720);
      expect(ScreenSizeHandler.screenHeight, 1280);
    });

    test('should update bigger and smaller dimensions correctly', () {
      ScreenSizeHandler.initialize(360, 640);

      expect(ScreenSizeHandler.bigger, 640);
      expect(ScreenSizeHandler.smaller, 360);

      ScreenSizeHandler.initialize(720, 1280);

      expect(ScreenSizeHandler.bigger, 1280);
      expect(ScreenSizeHandler.smaller, 720);
    });
  });
}
