class ScreenSizeHandler {
  double screenWidth;
  double screenHeight;
  double bigger = 0;
  double smaller = 0;

  ScreenSizeHandler(this.screenWidth, this.screenHeight) {
    if (screenWidth > screenHeight) {
      bigger = screenWidth;
      smaller = screenHeight;
    } else {
      bigger = screenHeight;
      smaller = screenWidth;
    }
  }
}
