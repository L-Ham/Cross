class ScreenSizeHandler {
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double bigger = 0;
  static double smaller = 0;

  static void initialize(double width, double height) {
    screenWidth = width;
    screenHeight = height;

    if (screenWidth > screenHeight) {
      bigger = screenWidth;
      smaller = screenHeight;
    } else {
      bigger = screenHeight;
      smaller = screenWidth;
    }
  }
}
